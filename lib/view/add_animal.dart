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
  final _formKeyState = GlobalKey<FormState>();
  late FocusNode firstFieldFocus;

  @override
  void initState() {
    super.initState();
    firstFieldFocus = FocusNode();
  }

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

  onSuccess() {
    _formKeyState.currentState!.reset();
    firstFieldFocus.requestFocus();
    setState(() {
      pet = Pet(id: 0, name: "", type: "");
    });
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Success"),
            content: Text("Pet is added"),
          );
        });
  }

  onLoading() async {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(children: const [
                CircularProgressIndicator(),
                SizedBox(
                  width: 20,
                ),
                Text("Saving")
              ]),
            ),
          );
        });

    await Provider.of<PetController>(context, listen: false).addPet(pet);
    Navigator.pop(context);
    onSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New")),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: InkWell(
                onTap: () async {
                  onLoading();
                },
                child: const Icon(Icons.save)),
            label: "Save"),
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
            const Text("Animal Details"),
            Form(
              key: _formKeyState,
              child: Column(children: [
                TextFormField(
                  focusNode: firstFieldFocus,
                  onChanged: onChangeName,
                  decoration: const InputDecoration(label: Text("Animal")),
                ),
                TextFormField(
                  onChanged: onChangeType,
                  decoration: const InputDecoration(label: Text("Animal Type")),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
