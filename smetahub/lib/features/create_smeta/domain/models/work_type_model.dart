import 'package:smetahub/features/create_smeta/domain/models/subspecies_work_type_model.dart';

class WorkTypeModel {
  final int id;
  final String name;
  final List<dynamic> subspeciesWorkTypes;

  WorkTypeModel({
    required this.id,
    required this.name,
    required this.subspeciesWorkTypes,
  });

  factory WorkTypeModel.fromJson(Map<String, dynamic> json) {
    return WorkTypeModel(
      id: json['id'],
      name: json['name'],
      subspeciesWorkTypes: json['subspecies_work_types']
          .map(
            (e) => SubspeciesWorkTypeModel(
              id: e["id"] ?? null,
              name: e["name"] ?? null,
            ),
          )
          .toList(),
    );
  }
}
