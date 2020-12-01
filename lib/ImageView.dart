import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart' show PermissionGroup, PermissionHandler, PermissionStatus;


class ImageView extends StatefulWidget {
  final String imgPath;

  ImageView({this.imgPath});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  var progress = "";
  bool downloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
              tag: widget.imgPath,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: kIsWeb
                  ? Image.network(widget.imgPath, fit: BoxFit.cover)
                : CachedNetworkImage(imageUrl: widget.imgPath,
                placeholder: (context, url) => Container(
                  color: Colors.white70,
                ),
                  fit: BoxFit.cover,
                ),
              ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RaisedButton(
                    onPressed: () async {
                      if(_checkAndGetPermission != null){
                      try{
                        var imgid= await ImageDownloader.downloadImage(widget.imgPath);
                        print(imgid+"\n\n"+widget.imgPath);
                        if(imgid == null){
                          return;
                        }
                        var filename = await ImageDownloader.findName(imgid);
                        print(filename);
                        Fluttertoast.showToast(
                            msg: "Image downloaded succesfully..",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );


                      }
                      on PlatformException catch (error){

                        print(error);
                      }}



                    },
                  child: Text("Download"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Colors.grey.withOpacity(0.5),
                  textColor: Colors.white,

                ),


                SizedBox(height: 16),

                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 Future<bool> _checkAndGetPermission() async {
final PermissionStatus permission = await PermissionHandler()
    .checkPermissionStatus(PermissionGroup.storage);
if (permission != PermissionStatus.granted) {
final Map<PermissionGroup, PermissionStatus> permissions =
await PermissionHandler()
    .requestPermissions(<PermissionGroup>[PermissionGroup.storage]);
if (permissions[PermissionGroup.storage] != PermissionStatus.granted) {
return null;
}
}
return true;
}

_save() async{
  var widget;
  var response = await Dio().get(widget.imgPath, options: Options(responseType: ResponseType.bytes));
  final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  print(result);
  BuildContext context;
  Navigator.pop(context);
}







