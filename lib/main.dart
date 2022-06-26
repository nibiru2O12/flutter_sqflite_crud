import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_crud/controller/pet_controller.dart';
import 'package:sql_crud/model/pet.dart';
import 'package:sql_crud/model/pet_db.dart';
import 'package:provider/provider.dart';
import 'package:sql_crud/view/add_animal.dart';
import 'package:sql_crud/view/edit_animal.dart';
import 'package:path/path.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PetController>(create: (_) => PetController())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Pets'),
      ),
    );
  }
}

Future<List<Pet>> fetchAnimalsFromDatabase() async {
  final db = PetHelper();
  Future<List<Pet>> animals = db.animals();
  return animals;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // showEditDialog() {
  //   showGeneralDialog(
  //       context: context,
  //       pageBuilder: (context, animation, animation2) {
  //         return EditPage();
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    var handler = Provider.of<PetController>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<PetController>(context, listen: false).deleteAll();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: FutureBuilder<List<Pet>>(
        future: handler.getList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var animals = snapshot.data ?? [];
          return ListView.builder(
              itemCount: animals.length,
              itemBuilder: (context, index) {
                var pet = animals[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {},
                  child: ListTile(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditPage(
                        pet: pet,
                      );
                    })),
                    title: Text("${animals[index].name} "),
                    trailing: Text(animals[index].type),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddPage();
          }));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
