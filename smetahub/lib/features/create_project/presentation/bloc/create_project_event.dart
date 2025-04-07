part of 'create_project_bloc.dart';

abstract class CreateProjectEvent {}

class GoToNextPageEvent extends CreateProjectEvent {}

class ShowObjectBottomSheetEvent extends CreateProjectEvent {}

class ShowCategoryBottomSheetEvent extends CreateProjectEvent {}

class ShowCurrentStateBottomSheetEvent extends CreateProjectEvent {}

class ShowFileBottomSheetEvent extends CreateProjectEvent {}

class CreateProjectNameEvent extends CreateProjectEvent {
  final String name;

  CreateProjectNameEvent({required this.name});
}

class SelectObjectTypeEvent extends CreateProjectEvent {
  final int projectId;
  final int objectTypeId;
  final String objectName;
  final String objectImage;

  SelectObjectTypeEvent({
    required this.projectId,
    required this.objectTypeId,
    required this.objectName,
    required this.objectImage,
  });
}

class SelectCategoryEvent extends CreateProjectEvent {
  final int projectId;
  final int projectCategoryId;
  final String categoryName;

  SelectCategoryEvent({
    required this.projectId,
    required this.projectCategoryId,
    required this.categoryName,
  });
}

class SelectCurrentStateEvent extends CreateProjectEvent {
  final int projectId;
  final int objectConditionId;
  final String objectConditionName;
  final String objectConditionImage;

  SelectCurrentStateEvent({
    required this.projectId,
    required this.objectConditionId,
    required this.objectConditionName,
    required this.objectConditionImage,
  });
}

class CreateTechConditionEvent extends CreateProjectEvent {
  final int projectId;
  final int area;

  CreateTechConditionEvent({
    required this.projectId,
    required this.area,
  });
}

class AddAiConsultantsEvent extends CreateProjectEvent {
  final List<AiConsultant> aiConsultants;

  AddAiConsultantsEvent({required this.aiConsultants});
}

class UploadFileEvent extends CreateProjectEvent {
  final String file;

  UploadFileEvent({required this.file});
}

class GetAllAIAgentsEvent extends CreateProjectEvent {}

class ChooseFileEvent extends CreateProjectEvent {}

class ChooseImageEvent extends CreateProjectEvent {}

class DeleteFileEvent extends CreateProjectEvent {
  final UploadedFileModel file;
  // final String fileName;

  DeleteFileEvent({
    required this.file,
    // required this.fileName,
  });
}
