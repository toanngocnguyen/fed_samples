import 'package:fedfer/model.dart';
import 'db_manager.dart';

class SampleObject extends FedObject {
  String? title;
  String? content;
  String? tags;

  SampleObject({
    FedObjectHelper? myHelper,
    super.id,
    this.title,
    this.content,
    this.tags,
  }) : super(myHelper: myHelper ?? SampleObject.gHelper);

  static FedObjectHelper<SampleObject> gHelper = FedObjectHelper.makeHelper(
    createNew: (FedObjectHelper helper) => SampleObject(myHelper: helper),
    tableName: 'sample_object',
    dbManager: DBManager.defaultDb,
  );

  @override
  Map<String, dynamic> toMap({Set<String>? included, Set<String>? excluded}) {
    return {
      if (myHelper.incExc('id', included, excluded)) 'id': id,
      if (myHelper.incExc('title', included, excluded)) 'title': title,
      if (myHelper.incExc('content', included, excluded)) 'content': content,
      if (myHelper.incExc('tags', included, excluded)) 'tags': tags,
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
      myHelper.tableName,
    );

    if (!bExisted) {
      await db.execute('''
      CREATE TABLE ${myHelper.tableName} (
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
