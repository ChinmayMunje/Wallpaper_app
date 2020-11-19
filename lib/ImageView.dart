import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final String imgPath;

  ImageView({this.imgPath});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
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
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xff1C1B1B).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(40),
                      ),


                      // alignment: Alignment.center,
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Colors.white24, width: 1),
                      //   borderRadius: BorderRadius.circular(40),
                      //   gradient: LinearGradient(
                      //     colors: [
                      //       Color(0x36FFFFFF),
                      //       Color(0x0FFFFFFF),
                      //     ],
                      //     begin: FractionalOffset.topLeft,
                      //     end: FractionalOffset.bottomRight,
                      //   ),
                      // ),
                      //
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white24, width: 1),
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                          colors: [
                            Color(0x36FFFFFF),
                            Color(0x0FFFFFFF),
                          ],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                        ),
                      ),

                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Set Wallpaper",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),

                            Text(
                              kIsWeb
                              ? "Image will open in new Tab"
                                  : "Image saved in gallery",
                              style: TextStyle(
                                fontSize: 8, color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                    ),
                  ],
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
