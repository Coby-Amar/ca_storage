import 'dart:convert';
import 'dart:math';

import 'package:ca_storage/api.dart';
import 'package:ca_storage/providers/tags.provider.dart';
import 'package:flutter/material.dart';

enum STATUS { watching, planned, onHold, finished, dropped, unknown }

extension StatusConverter on STATUS {
  STATUS fromValue(String value) {
    switch (value) {
      case 'watching':
        return STATUS.watching;
      case 'planned':
        return STATUS.planned;
      case 'on-hold':
        return STATUS.onHold;
      case 'finished':
        return STATUS.finished;
      case 'dropped':
        return STATUS.dropped;
      default:
        return STATUS.unknown;
    }
  }

  String toValue() {
    switch (this) {
      case STATUS.watching:
        return 'watching';
      case STATUS.planned:
        return 'planned';
      case STATUS.onHold:
        return 'on-hold';
      case STATUS.finished:
        return 'finished';
      case STATUS.dropped:
        return 'dropped';
      case STATUS.unknown:
        return 'unknown';
    }
  }

  String toDisplay() {
    switch (this) {
      case STATUS.watching:
        return 'Watching';
      case STATUS.planned:
        return 'Planned';
      case STATUS.onHold:
        return 'On-hold';
      case STATUS.finished:
        return 'Finished';
      case STATUS.dropped:
        return 'Dropped';
      case STATUS.unknown:
        return 'None';
    }
  }

  Color toColor() {
    switch (this) {
      case STATUS.watching:
        return Colors.green;
      case STATUS.planned:
        return Colors.blue;
      case STATUS.onHold:
        return Colors.yellow;
      case STATUS.finished:
        return Colors.blueGrey;
      case STATUS.dropped:
        return Colors.orange;
      case STATUS.unknown:
        return Colors.black;
    }
  }
}

class SeasonModel {
  int season = -1;
  int currentEp = -1;
  int maxEp = -1;

  SeasonModel();

  SeasonModel.fromMap(Map<String, dynamic> map) {
    season = map["season"];
    currentEp = map["currentEp"];
    maxEp = map["maxEp"];
  }

  Map<String, dynamic> toMap() => {
        "season": season,
        "currentEp": currentEp,
        "maxEp": maxEp,
      };
}

class EntryModel {
  String id = '';
  String name = '';
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  String category = '';
  List<TagModel> tags = [];
  List<SeasonModel> seasons = [];
  int latestSeason = -1;
  int latestEpisode = -1;
  STATUS status = STATUS.unknown;

  EntryModel();

  EntryModel.fromMap(Map<String, dynamic> map) {
    id = map["id"] ?? '';
    name = map["name"] ?? '';
    status =
        STATUS.dropped.fromValue(map["status"] ?? STATUS.unknown.toValue());
    createdAt = map["createdAt"] ?? DateTime.now();
    updatedAt = map["updatedAt"] ?? DateTime.now();
    category = map["category"] ?? '';
    tags = List<Map<String, dynamic>>.from(map["tags"])
        .map((e) => TagModel.fromMap(e))
        .toList();
    seasons = List<Map<String, dynamic>>.from(map["seasons"])
        .map((e) => SeasonModel.fromMap(e))
        .toList();
    latestSeason = map["latestSeason"] ?? -1;
    latestEpisode = map["latestEpisode"] ?? -1;
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "status": status.toValue(),
        "category": category,
        "tags": tags.map((e) => e.id).toList(),
        "seasons": seasons
            .where((element) => element.season > 0)
            .map((e) => e.toMap())
            .toList(),
      };
}

class EntriesProvider with ChangeNotifier {
  final List<EntryModel> entries = [];
  EntriesProvider() {
    ApiService().getEntries().then((value) {
      if (value != null) {
        entries.addAll(value);
        notifyListeners();
      }
    });
  }

  void createEntry(EntryModel entry) async {
    try {
      final createdEntry = await ApiService().createEntry(entry);
      entries.add(createdEntry);
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  void editEntry(EntryModel entry) async {
    try {
      final updatedEntry = await ApiService().updateEntry(entry);
      final foundIndex = entries.indexWhere((e) => e.id == updatedEntry.id);
      if (foundIndex > -1) {
        entries.replaceRange(foundIndex, foundIndex + 1, [updatedEntry]);
        notifyListeners();
      }
    } catch (e) {
      return null;
    }
  }

  void deleteEntry(EntryModel entry) async {
    try {
      await ApiService().deleteEntry(entry.id);
      entries.remove(entry);
      notifyListeners();
    } catch (e) {
      return null;
    }
  }

  void pauseEntry(EntryModel entry) async {
    try {
      await ApiService().pauseEntry(entry.id);
      final foundIndex = entries.indexWhere((e) => e.id == entry.id);
      if (foundIndex > -1) {
        entries.elementAt(foundIndex).status = STATUS.onHold;
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      return null;
    }
  }

  void dropEntry(EntryModel entry) async {
    try {
      await ApiService().dropEntry(entry.id);
      final foundIndex = entries.indexWhere((e) => e.id == entry.id);
      if (foundIndex > -1) {
        entries.elementAt(foundIndex).status = STATUS.dropped;
        notifyListeners();
      }
    } catch (e) {
      return null;
    }
  }

  void planningEntry(EntryModel entry) async {
    try {
      await ApiService().planningEntry(entry.id);
      final foundIndex = entries.indexWhere((e) => e.id == entry.id);
      if (foundIndex > -1) {
        entries.elementAt(foundIndex).status = STATUS.planned;
        notifyListeners();
      }
    } catch (e) {
      return null;
    }
  }
}
