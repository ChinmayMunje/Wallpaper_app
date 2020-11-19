import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:music/CategoryScreen.dart';
import 'package:music/Model/Photo_Model.dart';
import 'package:music/Search_View.dart';
import 'package:music/data/category_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> category = List<CategoryModel>();
  List<PhotoModel> photos = new List();
  int noOfImages = 60;

  getTrendingWallpaper() async {
    String apikey = "563492ad6f917000010000010e57141f30b2437cb7746c1519d63ee5";

    await http.get("https://api.pexels.com/v1/curated?per_page=$noOfImages&page=1",
    headers: {"Authorization": apikey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PhotoModel photoModel = new PhotoModel();
        photoModel = PhotoModel.fromMap(element);
        photos.add(photoModel);
      });
      setState(() {

      });
    });

  }
  @override
  void initState() {
    getTrendingWallpaper();
    category = getCategory();
    super.initState();

    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        noOfImages = noOfImages + 60;
        getTrendingWallpaper();
      }
    });

  }

  TextEditingController searchController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();

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
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 24),

                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'search wallpaper',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        if(searchController.text != ""){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_View(
                            search: searchController.text,
                          )));
                        }
                      },
                      child: Container(child: Icon(Icons.search,color: Colors.grey)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              //Category

              Container(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      imgUrl: category[index].imgUrl,
                      categoryName: category[index].categoryName,
                    );
                  }
                ),
              ),
              wallpaper(photos, context),
            ],
          ),
        ),
      ),
    );
  }
}


class CategoryModel{
  String imgUrl;
  String categoryName;

}

class CategoryCard extends StatelessWidget {
  final String imgUrl;
  final String categoryName;

  CategoryCard({this.imgUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(category: categoryName)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black26,
              ),
              child: Text(
                  categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

