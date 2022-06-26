class Pet {
  final int id;
  String name;
  String type;

  Pet({required this.id, required this.name, required this.type});

  Pet.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        type = map["classification"];

  Map<String, dynamic> toMap() {
    return {"name": name, "classification": type};
  }
}
