import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sql_crud/model/pet.dart';

class AnimalHelper {
  get database async {
    return initDb;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), "animal_database.db");

    return await openDatabase(path, onCreate: createDb, version: 1);
  }

  createDb(Database db, int version) async {
    await db.execute("""
  Create table animal(id INTEGER PRIMARY KEY, animal TEXT NOT NULL, type TEXT NOT NULL)
  """);
  }

  Future<int> insert(Pet animal) async {
    var db = await initDb();
    return db.insert("animal", animal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Pet animal) async {
    final db = await initDb();
    await db.update("animal", animal.toMap(),
        where: " id:? ", whereArgs: [animal.id]);
  }

  Future<List<Pet>> animals() async {
    final db = await initDb();
    List<Map<String, dynamic>> list = await db.query("animal");
    return List.generate(list.length, (index) => Pet.fromMap(list[index]));
  }
}
