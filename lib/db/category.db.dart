import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:ca_storage/db/models.db.dart';

class CategoryDataBase with ChangeNotifier {
  final Database database;
  final List<Category> categories = [];

  CategoryDataBase(this.database) {
    database.execute(
      '''CREATE TABLE IF NOT EXISTS
        ${Category.tableName}(
          ${BaseDatabaseModel.fieldId} TEXT PRIMARY KEY, 
          ${BaseDatabaseModel.fieldName} TEXT NOT NULL,
          ${BaseDatabaseModel.fieldCreatedAt} TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
          ${BaseDatabaseModel.fieldUpdatedAt} TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
          UNIQUE (${BaseDatabaseModel.fieldName})
        )''',
    );
  }

  Future<Iterable<Category>?> listCategories() async {
    try {
      List<Map<String, dynamic>> maps =
          await database.query(Category.tableName);
      print(maps);
      if (maps.isNotEmpty) {
        notifyListeners();
        return maps.toList().map((e) => Category.fromMap(e));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Category?> getCategory(String id) async {
    try {
      List<Map<String, dynamic>> maps = await database.query(
        Category.tableName,
        where: '${BaseDatabaseModel.fieldId} = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return Category.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> insert(Category category) async {
    try {
      print(category.toMap());
      await database.insert(Category.tableName, category.toMap());
      categories.add(category);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(Category category) async {
    try {
      await database.update(
        Category.tableName,
        category.toMap(),
        where: '${BaseDatabaseModel.fieldId} = ?',
        whereArgs: [category.id],
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await database.delete(
        Category.tableName,
        where: '${BaseDatabaseModel.fieldId} = ?',
        whereArgs: [id],
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
