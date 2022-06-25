class Pet {
  final int id;
  String name;
  String type;

  Pet({required this.id, required this.name, required this.type});

  Pet.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["animal"],
        type = map["type"];

  Map<String, dynamic> toMap() {
    return {"animal": name, "type": type};
  }
}
