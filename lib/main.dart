import 'package:flutter/material.dart';
import 'package:sql_crud/controller/pet_controller.dart';
import 'package:sql_crud/model/pet.dart';
import 'package:sql_crud/model/pet_db.dart';
import 'package:provider/provider.dart';
import 'package:sql_crud/view/add_animal.dart';
import 'package:sql_crud/view/edit_animal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
    // var list = Provider.of<PetController>(context).getList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Pet>>(
        future: handler.getList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();

          if (!snapshot.hasData) return CircularProgressIndicator();

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
