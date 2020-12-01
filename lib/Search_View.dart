import 'package:flutter/material.dart';
import 'package:music/CategoryScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:music/Model/Photo_Model.dart';




class Search_View extends StatefulWidget {
  final String search;


  Search_View({this.search});
  @override
  _Search_ViewState createState() => _Search_ViewState();
}

class _Search_ViewState extends State<Search_View> {

  List<PhotoModel> photos = new List();
  TextEditingController searchController = new TextEditingController();



  getSearchWallpaper(String searchQuery) async{
    String apikey = "563492ad6f917000010000010e57141f30b2437cb7746c1519d63ee5";
    await http.get("https://api.pexels.com/v1/search?query=$searchQuery&per_page=30&page=1",
        headers: {"Authorization": apikey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PhotoModel photosModel = new PhotoModel();
        photosModel = PhotoModel.fromMap(element);
        photos.add(photosModel);
      });

      setState(() {});
    });
  }
  @override
  void initState() {
    getSearchWallpaper(widget.search);
    searchController.text = widget.search;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:   Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Spot",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 23),),
              Text("Wallpaper",style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w600, fontSize: 23),),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black87),
                        controller: searchController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        getSearchWallpaper(searchController.text);
                      },
                      child: Container(child: Icon(Icons.search),),
                     ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              wallpaper(photos, context,60),
            ],
          ),
        ),
      ),
    );
  }
}
