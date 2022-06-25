import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_crud/controller/pet_controller.dart';
import 'package:sql_crud/model/pet.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Pet pet = Pet(id: 0, name: "", type: "");

  onChangeName(value) {
    setState(() {
      pet.name = value;
    });
  }

  onChangeType(value) {
    setState(() {
      pet.type = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New")),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: InkWell(
                onTap: () {
                  Provider.of<PetController>(context, listen: false)
                      .addPet(pet);
                },
                child: Icon(Icons.save)),
            label: "Save"),
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
          children: [
            Text("Animal Details"),
            TextField(
              onChanged: onChangeName,
              decoration: InputDecoration(label: Text("Animal")),
            ),
            TextField(
              onChanged: onChangeType,
              decoration: InputDecoration(label: Text("Animal Type")),
            )
          ],
        ),
      ),
    );
  }
}
