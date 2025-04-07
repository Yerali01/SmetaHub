// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProjectCategoryModel {
  final int? id;
  final String? name;
  ProjectCategoryModel({
    this.id,
    this.name,
  });

  factory ProjectCategoryModel.fromJson(Map<String, dynamic>? json) {
    return ProjectCategoryModel(
      id: json?['id'],
      name: json?['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
