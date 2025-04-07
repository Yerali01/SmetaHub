class MaterialTypeModel {
  final int id;
  final String name;
  final String description;

  MaterialTypeModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory MaterialTypeModel.fromJson(Map<String, dynamic> json) {
    return MaterialTypeModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
