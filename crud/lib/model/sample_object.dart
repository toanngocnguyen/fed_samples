import 'package:fedfer/model.dart';

import 'db_manager.dart';

class SampleObject extends FedObject {
  String? title;
  String? content;
  String? tags;

  SampleObject({
    FedStorageService? myHelper,
    super.id,
    this.title,
    this.content,
    this.tags,
  }) : super(storage: myHelper ?? SampleObject.gHelper);

  static FedStorageService<SampleObject> gHelper =
      FedStorageService.makeStorageService(
        createNew: (FedStorageService helper) => SampleObject(myHelper: helper),
        tableName: 'sample_object',
        dbManager: DBManager.defaultDb,
      );

  @override
  Map<String, dynamic> toMap({Set<String>? included, Set<String>? excluded}) {
    return {
      if (storage.incExc('id', included, excluded)) 'id': id,
      if (storage.incExc('title', included, excluded)) 'title': title,
      if (storage.incExc('content', included, excluded)) 'content': content,
      if (storage.incExc('tags', included, excluded)) 'tags': tags,
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = (map['id'] as String?) ?? '';
    title = map['title'] as String?;
    content = map['content'] as String?;
    tags = map['tags'] as String?;
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

  Future _createTable(Database db, int newVersion) async {
    bool bExisted = await FedDBManager.isTableExists(db, storage.tableName);

    if (!bExisted) {
      await db.execute('''
      CREATE TABLE ${storage.tableName} (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        tags TEXT NULL
      )
    ''');
    }
  }

  // --- CRUD OPERATIONS ---
  // automatically inherite from FedModel
}
