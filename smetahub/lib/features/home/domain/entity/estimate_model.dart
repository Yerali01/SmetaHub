import 'package:smetahub/features/create_smeta/domain/models/material_type_model.dart';

class EstimateModel {
  final int id;
  final String? name;
  final int? projectId;
  final String? projectName;
  final String? status;
  final MaterialTypeModel? materialType;

  EstimateModel({
    required this.id,
    this.name,
    this.projectId,
    this.projectName,
    this.status,
    this.materialType,
  });

  factory EstimateModel.fromJson(Map<String, dynamic> json) {
    return EstimateModel(
      id: json['id'],
      name: json['name'],
      projectId: json['project_id'],
      projectName: json['project_name'],
      status: json['status'],
      materialType: json['material_type'] != null
          ? MaterialTypeModel.fromJson(json['material_type'])
          : null,
    );
  }
}
