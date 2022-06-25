import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_crud/controller/pet_controller.dart';
import 'package:sql_crud/model/pet.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key, required this.pet}) : super(key: key);

  final Pet pet;
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late Pet newPet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newPet =
        Pet(id: widget.pet.id, name: widget.pet.name, type: widget.pet.type);
  }

  onChangeName(value) {
    setState(() {
      newPet.name = value;
    });
  }

  onChangeType(value) {
    setState(() {
      newPet.type = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editing"),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<PetController>(context, listen: false)
                    .delete(widget.pet.id);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: InkWell(
                onTap: () {
                  Provider.of<PetController>(context, listen: false)
                      .updatePet(newPet);
                },
                child: Icon(Icons.save)),
            label: "Update"),
        BottomNavigationBarItem(
            icon: InkWell(
              child: const Icon(Icons.cancel),
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
            TextFormField(
              onChanged: onChangeName,
              initialValue: newPet.name,
              decoration: InputDecoration(
                label: Text("Animal"),
              ),
            ),
            TextFormField(
              onChanged: onChangeType,
              initialValue: newPet.type,
              decoration: InputDecoration(label: Text("Animal Type")),
            )
          ],
        ),
      ),
    );
  }
}
