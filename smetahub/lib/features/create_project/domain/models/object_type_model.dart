class ObjectTypeModel {
  final int? id;
  final String? name;
  final String? photoDownloadUrl;

  ObjectTypeModel({
    this.id,
    this.name,
    this.photoDownloadUrl,
  });

  factory ObjectTypeModel.fromJson(Map<String, dynamic>? json) {
    return ObjectTypeModel(
      id: json?['id'],
      name: json?['name'],
      photoDownloadUrl: json?['photo_download_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo_download_url': photoDownloadUrl,
    };
  }
}
