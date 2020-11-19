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
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        ),
                      ),
                    ),
      InkWell(
        onTap: (){
          getSearchWallpaper(searchController.text);
        },
        child: Container(child: Icon(Icons.search_rounded)),

                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          wallpaper(photos, context),
        ],
      ),
    );
  }
}
