import 'package:flutter/material.dart';
import 'package:sql_crud/model/pet.dart';
import 'package:sql_crud/model/pet_db.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

fetchAnimalsFromDatabase() async {
  final db = AnimalHelper();
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
  showEditDialog() {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, animation2) {
          return EditPage();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: fetchAnimalsFromDatabase(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return ListView.builder(itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {},
              child: ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return EditPage();
                })),
                title: Text("animal ${index + 1}"),
                trailing: const Text("type of aninamal"),
              ),
            );
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final animal = Pet(id: 00, name: "Brix", type: "dog");
          var db = AnimalHelper();
          db.insert(animal);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editing")),
      bottomNavigationBar: BottomNavigationBar(items: [
        const BottomNavigationBarItem(icon: Icon(Icons.save), label: "Update"),
        BottomNavigationBarItem(
            icon: InkWell(
              child: Icon(Icons.cancel),
              onTap: () => Navigator.pop(context),
            ),
            label: "Cancel"),
      ]),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text("Animal Details"),
            TextField(
              decoration: InputDecoration(label: Text("Animal")),
            ),
            TextField(
              decoration: InputDecoration(label: Text("Animal Type")),
            )
          ],
        ),
      ),
    );
  }
}

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New")),
      bottomNavigationBar: BottomNavigationBar(items: [
        const BottomNavigationBarItem(icon: Icon(Icons.save), label: "Save"),
        BottomNavigationBarItem(
            icon: InkWell(
              child: Icon(Icons.cancel),
              onTap: () => Navigator.pop(context),
            ),
            label: "Cancel"),
      ]),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text("Animal Details"),
            TextField(
              decoration: InputDecoration(label: Text("Animal")),
            ),
            TextField(
              decoration: InputDecoration(label: Text("Animal Type")),
            )
          ],
        ),
      ),
    );
  }
}
