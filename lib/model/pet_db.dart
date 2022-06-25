import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sql_crud/model/pet.dart';

class PetHelper {
  get database async {
    return initDb;
  }

  Future<Database> initDb() async {
    var dbpath = await getDatabasesPath();
    print(dbpath);
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
    try {
      return await db.insert("animal", animal.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      throw e;
    }
  }

  Future<void> update(Pet animal) async {
    final db = await initDb();
    await db.update("animal", animal.toMap(),
        where: " id=? ", whereArgs: [animal.id]);
  }

  Future<List<Pet>> animals() async {
    final db = await initDb();
    List<Map<String, dynamic>> list = await db.query("animal");
    return List.generate(list.length, (index) => Pet.fromMap(list[index]));
  }

  Future<void> deleteAll() async {
    final db = await initDb();
    await db.delete(
      "animal",
    );
  }

  Future<void> delete(int petId) async {
    final db = await initDb();
    await db.delete("animal", where: "id = ?", whereArgs: [petId]);
  }
}
