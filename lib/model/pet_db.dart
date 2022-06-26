import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sql_crud/model/pet.dart';
import 'package:sql_crud/utils/database.dart';

class PetHelper {
  get database async {
    return initDb;
  }

  Future<Database> initDb() async {
    await copyDbFromAssets();

    String path = join(await getDatabasesPath(), "pet_database.db");

    return await openDatabase(path, onCreate: await copyDbFromAssets(),
        onUpgrade: (db, oldVersion, newVersion) {
      if (oldVersion < newVersion) {
        var migration = [
          "  INSERT INTO pets (id, name, classification) VALUES (1, 'CC', 'Dog');",
          "INSERT INTO pets (id, name, classification) VALUES (2, 'brix', 'dog');",
          "INSERT INTO pets (id, name, classification) VALUES (3, 'ming ming', 'cat');",
          "INSERT INTO pets (id, name, classification) VALUES (4, 'clenton', 'dog');"
        ];
        Batch batch = db.batch();
        for (var m in migration) {
          batch.rawInsert(m);
        }
        batch.commit();
      }
    }, version: 14);
  }

  createDb(Database db, int version) async {
    await db.execute("""
  Create table pets(id INTEGER PRIMARY KEY, animal TEXT NOT NULL, type TEXT NOT NULL)
  """);
  }

  Future<int> insert(Pet animal) async {
    var db = await initDb();
    try {
      return await db.insert("pets", animal.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      throw e;
    }
  }

  Future<void> update(Pet animal) async {
    final db = await initDb();
    await db.update("pets", animal.toMap(),
        where: " id=? ", whereArgs: [animal.id]);
  }

  Future<List<Pet>> animals() async {
    final db = await initDb();
    List<Map<String, dynamic>> list = await db.query("pets");
    return List.generate(list.length, (index) => Pet.fromMap(list[index]));
  }

  Future<void> deleteAll() async {
    final db = await initDb();
    await db.delete(
      "pets",
    );
  }

  Future<void> delete(int petId) async {
    final db = await initDb();
    await db.delete("pets", where: "id = ?", whereArgs: [petId]);
  }
}
