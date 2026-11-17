// import '../model.dart';
// import 'package:flutter/widgets.dart';

import 'package:fedfer/model.dart';
import '../model.dart';

class AppSetting extends FedObject {
  int lastProcessed = 0;
  int lastGetFromInbox = 0;
  int totalProcessed = 0;
  int totalIncome = 0;

  AppSetting({
    FedObjectHelper? helper,
    super.id,
    this.lastProcessed = 0,
    this.lastGetFromInbox = 0,
    this.totalProcessed = 0,
    this.totalIncome = 0,
  }) : super(helper: helper ?? AppSetting.helper);

  static final FedObjectHelper<AppSetting> helper = FedObjectHelper.makeHelper(
    createNew: (FedObjectHelper helper) => AppSetting(helper: helper),
    tableName: 'app_setting',
    dbManager: DBManager.defaultDb,
  );

  // Convert a SampleModel object into a Map. Object keys must match database columns.
  @override
  Map<String, dynamic> toMap({Set<String>? included, Set<String>? excluded}) {
    return {
      'id': id,
      'lastProcessed': lastProcessed,
      'lastGetFromInbox': lastGetFromInbox,
      'totalProcessed': totalProcessed,
      'totalIncome': totalIncome,
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = (map['id'] as String?) ?? '';
    lastProcessed = (map['lastProcessed'] as int?) ?? -1;
    lastGetFromInbox = (map['lastGetFromInbox'] as int?) ?? -1;
    totalProcessed = (map['totalProcessed'] as int?) ?? -1;
    totalIncome = (map['totalIncome'] as int?) ?? -1;
  }

  // --- Metadata definition ---
  @override
  Future manageModel(Database db, int oldVersion, int newVersion) async {
    // onCreate model
    if (oldVersion == -1) {
      _createTable(db, newVersion);
    }
    // onUpgrade model
    else {}
  }

  Future _createTable(Database db, int version) async {
    bool bExisted = await FedDBManager.isTableExists(
      db,
      objectHelper.tableName,
    );

    if (!bExisted) {
      await db.execute('''
      CREATE TABLE ${objectHelper.tableName} (
        id TEXT PRIMARY KEY,
        lastProcessed INTEGER NOT NULL,
        lastGetFromInbox INTEGER NOT NULL,
        totalProcessed INTEGER NULL,
        totalIncome INTEGER NULL
      )
    ''');
    }
  }

  // --- CRUD OPERATIONS ---
  // automatically inherite from FedModel
  //

  /// Creates an object from a JSON [Map].
  factory AppSetting.fromJson(Map<String, dynamic> json) => AppSetting(
    id: json['id'],
    lastProcessed: json['lastProcessed'],
    lastGetFromInbox: json['lastGetFromInbox'],
    totalProcessed: json['totalProcessed'],
    totalIncome: json['totalIncome'],
  );

  /// Converts this object instance to a JSON [Map].
  Map<String, dynamic> toJson() => {
    'id': id,
    'lastProcessed': lastProcessed,
    'lastGetFromInbox': lastGetFromInbox,
    'totalProcessed': totalProcessed,
    'totalIncome': totalIncome,
  };
}
