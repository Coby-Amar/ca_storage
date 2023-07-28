import 'package:uuid/uuid.dart';

const _uuid = Uuid();

enum Status {
  onGoing,
  finished,
  paused,
  dropped,
  rewatching,
  unknown,
}

extension Addittion on Status {
  String get toUi => toString().split('.').last;

  Status fromString(String possableStatus) => Status.values.firstWhere(
        (e) => e.toUi == possableStatus,
        orElse: () => Status.unknown,
      );
}

class BaseDatabaseModel {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  static const fieldId = 'id';
  static const fieldName = 'name';
  static const fieldCreatedAt = 'created_at';
  static const fieldUpdatedAt = 'updated_at';

  const BaseDatabaseModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  BaseDatabaseModel.empty({String? name})
      : id = _uuid.v4(),
        name = name ?? '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  BaseDatabaseModel.fromMap(Map<String, dynamic> map)
      : id = map[BaseDatabaseModel.fieldId],
        name = map[BaseDatabaseModel.fieldName],
        createdAt = map[BaseDatabaseModel.fieldCreatedAt],
        updatedAt = map[BaseDatabaseModel.fieldUpdatedAt];

  Map<String, dynamic> toMap() => {
        BaseDatabaseModel.fieldId: id,
        BaseDatabaseModel.fieldName: name,
      };
}

class Category extends BaseDatabaseModel {
  static const tableName = 'CATEGORY';

  const Category({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  Category.empty({String? name}) : super.empty(name: name);
  Category.fromMap(Map<String, dynamic> map) : super.fromMap(map);
}

class SubCategory extends BaseDatabaseModel {
  static const tableName = 'SUB_CATEGORY';
  static const fieldCategoryId = 'CATEGORY_ID';
  final String categoryId;

  const SubCategory({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    required this.categoryId,
  });

  SubCategory.empty()
      : categoryId = '',
        super.empty();

  SubCategory.fromMap(Map<String, dynamic> map)
      : categoryId = map[SubCategory.fieldCategoryId],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        SubCategory.fieldCategoryId: categoryId,
      };
}

class Item extends BaseDatabaseModel {
  static const tableName = 'ITEM';
  static const fieldCurrentEpisode = 'current_episode';
  static const fieldMaxEpisode = 'max_episode';
  static const fieldCurrentSeason = 'current_season';
  static const fieldMaxSeason = 'max_season';
  static const fieldStatus = 'status';
  final String categoryId;
  final int currentEpisode;
  final int maxEpisode;
  final int currentSeason;
  final int maxSeason;
  final Status status;

  const Item({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    required this.categoryId,
    required this.currentEpisode,
    required this.maxEpisode,
    required this.currentSeason,
    required this.maxSeason,
    required this.status,
  });

  Item.fromMap(Map<String, dynamic> map)
      : categoryId = map[SubCategory.fieldCategoryId],
        currentEpisode = map[Item.fieldCurrentEpisode],
        maxEpisode = map[Item.fieldMaxEpisode],
        currentSeason = map[Item.fieldCurrentSeason],
        maxSeason = map[Item.fieldMaxSeason],
        status = map[Item.fieldStatus],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        SubCategory.fieldCategoryId: categoryId,
        Item.fieldCurrentEpisode: currentEpisode,
        Item.fieldMaxEpisode: maxEpisode,
        Item.fieldCurrentSeason: currentSeason,
        Item.fieldMaxSeason: maxSeason,
        Item.fieldStatus: status,
      };
}
