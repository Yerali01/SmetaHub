class SubspeciesWorkTypeModel {
  final int? id;
  final String? name;

  SubspeciesWorkTypeModel({
    this.id,
    this.name,
  });

  factory SubspeciesWorkTypeModel.fromJson(Map<String, dynamic> json) {
    return SubspeciesWorkTypeModel(
      id: json['id'] ?? null,
      name: json['name'] ?? null,
    );
  }
}
