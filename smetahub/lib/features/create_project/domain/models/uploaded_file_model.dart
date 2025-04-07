class UploadedFileModel {
  final int? id;
  final int? projectId;
  final String? name;
  final int? fileSize;
  final String? description;
  final String? downloadUrl;

  UploadedFileModel({
    this.id,
    this.projectId,
    this.name,
    this.fileSize,
    this.description,
    this.downloadUrl,
  });

  factory UploadedFileModel.fromJson(Map<String, dynamic> json) {
    return UploadedFileModel(
      id: json['id'] ?? 0,
      projectId: json['project_id'] ?? 0,
      name: json['filename'] ?? '',
      fileSize: json['file_size'] ?? 0,
      description: json['description'] ?? '',
      downloadUrl: json['download_url'] ?? '',
    );
  }
}
