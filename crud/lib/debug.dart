// import 'dart:js_interop';
// import 'dart:typed_data';

// import 'package:sqflite/sqflite.dart';

// import 'package:web/web.dart' as web;

Future<void> downloadDatabase(String dbName) async {
  // // 1. Read raw SQLite bytes from IndexedDB
  // final Uint8List bytes = await databaseFactory.readDatabaseBytes(dbName);

  // // 2. Create a downloadable Blob in Chrome
  // final blob = web.Blob([bytes.toJS].toJS);
  // final url = web.URL.createObjectURL(blob);

  // // 3. Trigger download
  // final anchor = web.document.createElement('a') as web.HTMLAnchorElement
  //   ..href = url
  //   ..download = dbName;
  // anchor.click();

  // web.URL.revokeObjectURL(url);
}
