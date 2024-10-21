import 'package:ca_storage/api.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String id = '';
  String name = '';
  CategoryModel.fromMap(Map<String, dynamic> map) {
    id = map["id"] ?? '';
    name = map["name"] ?? '';
  }
}

class CategoriesProvider with ChangeNotifier {
  final List<CategoryModel> categories = [];
  CategoriesProvider() {
    ApiService().getCategories().then((value) {
      if (value != null) {
        categories.addAll(value);
        notifyListeners();
      }
    });
  }
}
