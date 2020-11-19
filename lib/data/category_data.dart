

import 'package:music/Home.dart';

List<CategoryModel> getCategory() {
  List<CategoryModel> myCategory = List<CategoryModel>();
  CategoryModel categoryModel;

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Nature";
  categoryModel.imgUrl = "https://images.pexels.com/photos/2387873/pexels-photo-2387873.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  myCategory.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Travel";
  categoryModel.imgUrl = "https://images.pexels.com/photos/672358/pexels-photo-672358.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  myCategory.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Architecture";
  categoryModel.imgUrl = "https://images.pexels.com/photos/256150/pexels-photo-256150.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  myCategory.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Art";
  categoryModel.imgUrl = "https://images.pexels.com/photos/1194420/pexels-photo-1194420.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  myCategory.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Music";
  categoryModel.imgUrl = "https://images.pexels.com/photos/4348093/pexels-photo-4348093.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  myCategory.add(categoryModel);


  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Abstract";
  categoryModel.imgUrl = "https://images.pexels.com/photos/2110951/pexels-photo-2110951.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  myCategory.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Cars";
  categoryModel.imgUrl = "https://images.pexels.com/photos/3802510/pexels-photo-3802510.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  myCategory.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Flowers";
  categoryModel.imgUrl = "https://images.pexels.com/photos/1086178/pexels-photo-1086178.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  myCategory.add(categoryModel);


  return myCategory;
}