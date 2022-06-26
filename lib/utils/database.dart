import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

copyDbFromAssets() async {
  String databasePath = await getDatabasesPath();
  String path = join(databasePath, "pet_database.db");

// Only copy if the database doesn't exist
  if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
    print("does not exits");
    // Load database from asset and copy
    ByteData data = await rootBundle.load(join('assets', 'database', 'db.db'));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Save copied asset to documents
    await new File(path).writeAsBytes(bytes, flush: true);
  }
}
