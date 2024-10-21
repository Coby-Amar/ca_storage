import 'package:ca_storage/api.dart';
import 'package:flutter/material.dart';

class TagModel {
  String id = '';
  String name = '';
  TagModel.fromMap(Map<String, dynamic> map) {
    id = map["id"] ?? '';
    name = map["name"] ?? '';
  }
}

class TagsProvider with ChangeNotifier {
  final List<TagModel> tags = [];
  TagsProvider() {
    ApiService().getTags().then((value) {
      if (value != null) {
        tags.addAll(value);
        notifyListeners();
      }
    });
  }
}
