import 'package:fedfer/model.dart';

import 'db_manager.dart';

class SampleObject extends FedObject {
  String? title;
  String? content;
  String? tags;

  SampleObject({
    FedModelHelper? model,
    super.id,
    this.title,
    this.content,
    this.tags,
  }) : super(model: model ?? SampleObject.modelHelper);

  static FedModelHelper<SampleObject> modelHelper =
      FedModelHelper.makeModelHelper(
        createNew: (FedModelHelper helper) => SampleObject(model: helper),
        tableName: 'sample_object',
        dbManager: DBManager.defaultDb,
      );

  @override
  Map<String, dynamic> toMap({Set<String>? included, Set<String>? excluded}) {
    return {
      if (model.incExc('id', included, excluded)) 'id': id,
      if (model.incExc('title', included, excluded)) 'title': title,
      if (model.incExc('content', included, excluded)) 'content': content,
      if (model.incExc('tags', included, excluded)) 'tags': tags,
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
    bool bExisted = await FedDBManager.isTableExists(db, model.tableName);

    if (!bExisted) {
      await db.execute('''
      CREATE TABLE ${model.tableName} (
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
