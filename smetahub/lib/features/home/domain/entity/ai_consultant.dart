class AiConsultant {
  final int id;
  final String? image;
  final String name;
  final bool isActive;

  AiConsultant({
    required this.id,
    this.image,
    required this.name,
    required this.isActive,
  });

  factory AiConsultant.fromJson(Map<String, dynamic> json) {
    return AiConsultant(
      id: json['id'],
      name: json['name'],
      image: json['photo_download_url'],
      isActive: json['is_active'],
    );
  }
}
