import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ca_storage/db/models.db.dart';

class SubCategoryDataBase with ChangeNotifier {
  final Database database;
  final List<SubCategory> subCategories = [];

  SubCategoryDataBase(this.database) {
    database.execute(
      '''CREATE TABLE IF NOT EXISTS
        ${SubCategory.tableName}(
          ${BaseDatabaseModel.fieldId} INTEGER PRIMARY KEY, 
          ${SubCategory.fieldCategoryId} INTEGER FOREIGN KEY REFERENCES parent(${BaseDatabaseModel.fieldId}), 
          ${BaseDatabaseModel.fieldName} TEXT NOT NULL,
          ${BaseDatabaseModel.fieldCreatedAt} TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
          ${BaseDatabaseModel.fieldUpdatedAt} TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
          UNIQUE (${BaseDatabaseModel.fieldName})
        )''',
    );
  }

  Future<Iterable<SubCategory>?> listCategories() async {
    try {
      List<Map<String, dynamic>> maps =
          await database.query(SubCategory.tableName);
      if (maps.isNotEmpty) {
        return maps.toList().map((e) => SubCategory.fromMap(e));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<SubCategory?> getSubCategory(String id) async {
    try {
      List<Map<String, dynamic>> maps = await database.query(
        SubCategory.tableName,
        where: '${BaseDatabaseModel.fieldId} = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return SubCategory.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> insert(SubCategory subCategory) async {
    try {
      await database.insert(SubCategory.tableName, subCategory.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(SubCategory subCategory) async {
    try {
      await database.update(
        SubCategory.tableName,
        subCategory.toMap(),
        where: '${BaseDatabaseModel.fieldId} = ?',
        whereArgs: [subCategory.id],
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await database.delete(
        SubCategory.tableName,
        where: '${BaseDatabaseModel.fieldId} = ?',
        whereArgs: [id],
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
