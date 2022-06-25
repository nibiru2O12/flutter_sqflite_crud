import 'package:flutter/cupertino.dart';
import 'package:sql_crud/model/pet.dart';
import 'package:sql_crud/model/pet_db.dart';

class PetController extends ChangeNotifier {
  Future<List<Pet>> getList() {
    return PetHelper().animals();
  }

  void addPet(Pet animal) async {
    await PetHelper().insert(animal);
    notifyListeners();
  }

  void updatePet(Pet animal) async {
    await PetHelper().update(animal);
    notifyListeners();
  }

  void deleteAll() async {
    await PetHelper().deleteAll();
    notifyListeners();
  }
}
