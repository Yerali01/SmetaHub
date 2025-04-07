import 'package:smetahub/features/create_project/domain/models/file_model.dart';
import 'package:smetahub/features/create_project/domain/models/object_condition_model.dart';
import 'package:smetahub/features/create_project/domain/models/object_type_model.dart';
import 'package:smetahub/features/create_project/domain/models/project_category_model.dart';
import 'package:smetahub/features/create_project/domain/models/tech_condition_model.dart';
import 'package:smetahub/features/home/domain/entity/ai_consultant.dart';

class ProjectModel {
  final int? id;
  final String? name;
  final String? description;
  final ObjectTypeModel? objectType;
  final ProjectCategoryModel? category;
  final ObjectConditionModel? objectCondition;
  final List<dynamic>? files;
  final String? status;
  final TechConditionModel? technicalConditions;
  final List<dynamic>? aiAgents;

  ProjectModel({
    this.id,
    this.name,
    this.description,
    this.objectType,
    this.category,
    this.objectCondition,
    this.files,
    this.status,
    this.technicalConditions,
    this.aiAgents,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      objectType: ObjectTypeModel.fromJson(json['object_type']),
      category: ProjectCategoryModel.fromJson(json['category']),
      objectCondition: ObjectConditionModel.fromJson(json['object_condition']),
      files: json['files'] != null
          ? json['files'].map((item) {
              return FileModel.fromJson(item);
            }).toList()
          : [],
      status: json['status'],
      technicalConditions:
          TechConditionModel.fromJson(json['technical_conditions']),
      aiAgents: json['agents'] != null
          ? json['agents'].map((item) {
              if (item != null) return AiConsultant.fromJson(item);
            }).toList()
          : [],
    );
  }

  ProjectModel copyWith({
    int? id,
    String? name,
    String? description,
    ObjectTypeModel? objectType,
    ProjectCategoryModel? category,
    ObjectConditionModel? objectCondition,
    List<dynamic>? files,
    String? status,
    TechConditionModel? technicalConditions,
    List<dynamic>? aiAgents,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      objectType: objectType ?? this.objectType,
      category: category ?? this.category,
      objectCondition: objectCondition ?? this.objectCondition,
      files: files ?? this.files,
      status: status ?? this.status,
      technicalConditions: technicalConditions ?? this.technicalConditions,
      aiAgents: aiAgents ?? this.aiAgents,
    );
  }
}
