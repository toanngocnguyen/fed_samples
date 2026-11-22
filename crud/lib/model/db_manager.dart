import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'package:fedfer/model.dart';

import '../model.dart';

/// Each database will have a similar DBManager object
class DBManager extends FedDBManager {
  DBManager({super.databaseName, super.version});

  static DBManager defaultDb = DBManager(
    databaseName: 'fedfer_samples.db',
    version: 2,
  );

  @override
  Future<void> init() async {
    // For running sqflite in browser debug mode
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }

    // add model classes into the database
    DBManager.defaultDb.addModel(User.storageService);
    DBManager.defaultDb.addModel(SampleObject.gHelper);
  }
}
