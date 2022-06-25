class Pet {
  final int id;
  final String name;
  final String type;

  const Pet({required this.id, required this.name, required this.type});

  Pet.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["animal"],
        type = map["type"];

  Map<String, dynamic> toMap() {
    return {"animal": name, "type": type};
  }
}
