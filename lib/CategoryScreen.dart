import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:music/ImageView.dart';
import 'package:music/Model/Photo_Model.dart';

//API KEY 563492ad6f917000010000010e57141f30b2437cb7746c1519d63ee5


class CategoryScreen extends StatefulWidget {
  final String category;

  CategoryScreen({this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  List<PhotoModel> photos = new List();

  Future<void> getCategoryWallpaper() async {
    String apikey = "563492ad6f917000010000010e57141f30b2437cb7746c1519d63ee5";
    String url = "https://api.pexels.com/v1/search?query=${widget
        .category}&per_page=30&page=1";

    await http.get(url, headers: {"Authorization": apikey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotoModel photoModel = new PhotoModel();
        photoModel = PhotoModel.fromMap(element);
        photos.add(photoModel);
        print(photoModel);
      });
      setState(() {

      });
    });
    }
  @override
  void initState() {
    getCategoryWallpaper();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Spot",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 23),),
            Text("Wallpaper",style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w600, fontSize: 23),),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: wallpaper(photos, context),
      ),
    );
  }
}
Widget wallpaper (List<PhotoModel> listPhoto, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: OrientationBuilder(
      builder: (context, orientation){
        return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            childAspectRatio: 0.6,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(4.0),
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
            children: listPhoto.map((PhotoModel photoModel) {
              return GridTile(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageView(
                                imgPath: photoModel.src.portrait,
                              )));
                    },
                    child: Hero(
                      tag: photoModel.src.portrait,
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: kIsWeb
                              ? Image.network(
                            photoModel.src.portrait,
                            height: 50,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                              : CachedNetworkImage(
                              imageUrl: photoModel.src.portrait,
                              placeholder: (context, url) => Container(
                                color: Color(0xfff5f8fd),
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ));
            }).toList());
      }
    ),
  );
}

