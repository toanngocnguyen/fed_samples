import 'package:fedfer/model.dart';
import 'db_manager.dart';

class SampleObject extends FedObject {
  String? title;
  String? content;
  String? tags;

  SampleObject({
    FedObjectHelper? helper,
    super.id,
    this.title,
    this.content,
    this.tags,
  }) : super(helper: helper ?? SampleObject.helper);

  static FedObjectHelper<SampleObject> helper = FedObjectHelper.makeHelper(
    createNew: (FedObjectHelper helper) => SampleObject(helper: helper),
    tableName: 'sample_object',
    dbManager: DBManager.defaultDb,
  );

  @override
  Map<String, dynamic> toMap({Set<String>? included, Set<String>? excluded}) {
    return {
      if ((included?.contains('id')??true) && !(excluded?.contains('id')??false)) 'id': id,
      if ((included?.contains('title')??true) && !(excluded?.contains('title')??false)) 'title': title,
      if ((included?.contains('content')??true) && !(excluded?.contains('content')??false)) 'content': content,
      if ((included?.contains('tags')??true) && !(excluded?.contains('tags')??false)) 'tags': tags,
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
    bool bExisted = await FedDBManager.isTableExists(
      db,
      objectHelper.tableName,
    );

    if (!bExisted) {
      await db.execute('''
      CREATE TABLE ${objectHelper.tableName} (
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
