import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:ca_storage/db/models.db.dart';

class ItemDataBase with ChangeNotifier {
  final Database database;
  final List<Item> items = [];

  ItemDataBase(this.database) {
    database.execute(
      '''CREATE TABLE IF NOT EXISTS
        ${Item.tableName}(
          ${BaseDatabaseModel.fieldId} INTEGER PRIMARY KEY, 
          ${SubCategory.fieldCategoryId} INTEGER FOREIGN KEY REFERENCES parent(${BaseDatabaseModel.fieldId}), 
          ${BaseDatabaseModel.fieldName} TEXT NOT NULL,
          ${BaseDatabaseModel.fieldCreatedAt} TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
          ${BaseDatabaseModel.fieldUpdatedAt} TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
          ${Item.fieldCurrentEpisode} INTEGER NOT NULL,
          ${Item.fieldMaxEpisode} INTEGER NOT NULL,
          ${Item.fieldCurrentSeason} INTEGER NOT NULL,
          ${Item.fieldMaxSeason} INTEGER NOT NULL,
          ${Item.fieldStatus} TEXT NOT NULL,
          UNIQUE (${BaseDatabaseModel.fieldName})
        )''',
    );
  }

  Future<bool> listItems() async {
    try {
      List<Map<String, dynamic>> maps = await database.query(Item.tableName);
      if (maps.isNotEmpty) {
        items.addAll(
          maps.toList().map(
                (e) => Item.fromMap(e),
              ),
        );
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insert(Item item) async {
    try {
      await database.insert(Item.tableName, item.toMap());
      items.add(item);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await database.delete(
        Item.tableName,
        where: '${BaseDatabaseModel.fieldId} = ?',
        whereArgs: [id],
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
