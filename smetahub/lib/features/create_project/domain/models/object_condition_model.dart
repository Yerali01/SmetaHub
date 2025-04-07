class ObjectConditionModel {
  final int? id;
  final String? name;
  final String? image;
  ObjectConditionModel({
    this.id,
    this.name,
    this.image,
  });

  factory ObjectConditionModel.fromJson(Map<String, dynamic>? json) {
    return ObjectConditionModel(
      id: json?['id'],
      name: json?['name'],
      image: json?['photo_download_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo_download_url': image,
    };
  }
}
