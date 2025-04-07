class FileModel {
  final int? id;
  final String? name;
  final String? downloadUrl;

  FileModel({
    this.id,
    this.name,
    this.downloadUrl,
  });

  factory FileModel.fromJson(Map<String, dynamic>? json) {
    return FileModel(
      id: json?['id'],
      name: json?['filename'],
      downloadUrl: json?['download_url'],
    );
  }
}
