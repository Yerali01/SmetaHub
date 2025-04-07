part of 'create_smeta_bloc.dart';

abstract class CreateSmetaEvent {}

class CreateUserSmetaEvent extends CreateSmetaEvent {
  final int? projectId;

  CreateUserSmetaEvent({
    required this.projectId,
  });
}

class GetWorkTypesEvent extends CreateSmetaEvent {}

class GetMaterialTypesEvent extends CreateSmetaEvent {}

class SelectSubspeciesWorkTypeEvent extends CreateSmetaEvent {
  final List<SubspeciesWorkTypeModel> subspeciesWorkTypes;
  SelectSubspeciesWorkTypeEvent({
    required this.subspeciesWorkTypes,
  });
}

class AddMaterialTypeEvent extends CreateSmetaEvent {
  final int estimateId;
  final int materialTypeId;
  AddMaterialTypeEvent({
    required this.estimateId,
    required this.materialTypeId,
  });
}

class AddSpecialRequirementsEvent extends CreateSmetaEvent {
  final String text;
  AddSpecialRequirementsEvent({
    required this.text,
  });
}

class CreateSmetaNameEvent extends CreateSmetaEvent {
  final String name;
  CreateSmetaNameEvent({
    required this.name,
  });
}

class GenerateEstimateEvent extends CreateSmetaEvent {
  final int estimateId;
  GenerateEstimateEvent({
    required this.estimateId,
  });
}

class GoNextPageEvent extends CreateSmetaEvent {}

class ChooseAllSectionOptionsEvent extends CreateSmetaEvent {
  final List sectionOptions;
  ChooseAllSectionOptionsEvent({
    required this.sectionOptions,
  });
}

class GetProjectsEvent extends CreateSmetaEvent {}

class ChooseAllEverythingEvent extends CreateSmetaEvent {}

class SelectProjectEvent extends CreateSmetaEvent {
  final ProjectModel project;
  SelectProjectEvent({
    required this.project,
  });
}

class AddWorkOptionEvent extends CreateSmetaEvent {
  final SubspeciesWorkTypeModel workOption;
  AddWorkOptionEvent({
    required this.workOption,
  });
}

class ChooseMaterialEvent extends CreateSmetaEvent {
  final MaterialTypeModel material;
  ChooseMaterialEvent({
    required this.material,
  });
}

// class AddMaterialEvent extends CreateSmetaEvent {
//   final MaterialTypeModel material;
//   AddMaterialEvent({
//     required this.material,
//   });
// }
