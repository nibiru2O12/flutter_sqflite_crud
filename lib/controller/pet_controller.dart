import 'package:flutter/cupertino.dart';
import 'package:sql_crud/model/pet.dart';
import 'package:sql_crud/model/pet_db.dart';

enum fetchStatus { failed, success }

class RequestStatus {
  fetchStatus? status;
  Object? error;
  Object? data;
  RequestStatus({this.status, this.error, this.data});
}

class PetController extends ChangeNotifier {
  bool inProgress = true;

  Future<List<Pet>> getList() {
    return PetHelper().animals();
  }

  doWork() {
    inProgress = true;
    notifyListeners();
  }

  Future<int> addPet(Pet animal) async {
    return Future.delayed(Duration(seconds: 5), () async {
      try {
        return await PetHelper()
            .insert(animal)
            .whenComplete(() => notifyListeners());
      } catch (e) {
        throw e;
      }
    });
    try {
      return await PetHelper()
          .insert(animal)
          .whenComplete(() => notifyListeners());
    } catch (e) {
      throw e;
    }
  }

  void updatePet(Pet animal) async {
    await PetHelper()
        .update(animal)
        .whenComplete(() => notifyListeners())
        .onError((error, stackTrace) => print(error));
  }

  void deleteAll() async {
    await PetHelper().deleteAll();
    notifyListeners();
  }

  void delete(int petId) async {
    await PetHelper().delete(petId);
    notifyListeners();
  }
}
