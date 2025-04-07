class TechConditionModel {
  final int? id;
  final double? area;

  TechConditionModel({
    this.id,
    this.area,
  });

  factory TechConditionModel.fromJson(Map<String, dynamic>? json) {
    return TechConditionModel(
      id: json?['id'],
      area: json?['area'],
    );
  }
}
