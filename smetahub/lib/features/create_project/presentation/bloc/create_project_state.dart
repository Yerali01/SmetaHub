part of 'create_project_bloc.dart';

abstract class CreateProjectState {}

class ShowCreateProjectState extends CreateProjectState {
  ShowCreateProjectState({
    required this.currentPage,
    required this.isOpenObjectBottomSheet,
    required this.isOpenCategoryBottomSheet,
    required this.isOpenCurrentStateBottomSheet,
    required this.isOpenFileBottomSheet,
    required this.projectId,
    required this.objectTypes,
    required this.projectCategories,
    required this.objectConditions,
    // required this.pickedFiles,
    // required this.pickedImages,
    required this.uploadedFilesAndImages,
    required this.aiAgents,
  });

  final int currentPage;
  final bool isOpenObjectBottomSheet;
  final bool isOpenCategoryBottomSheet;
  final bool isOpenCurrentStateBottomSheet;
  final bool isOpenFileBottomSheet;
  final int projectId;
  final List<ObjectTypeModel> objectTypes;
  final List<ProjectCategoryModel> projectCategories;
  final List<ObjectConditionModel> objectConditions;
  // final List<PlatformFile> pickedFiles;
  // final List<XFile> pickedImages;
  final List<UploadedFileModel> uploadedFilesAndImages;
  final List<AiConsultant> aiAgents;

  ShowCreateProjectState copyWith({
    int? currentPage,
    bool? isOpenObjectBottomSheet,
    bool? isOpenCategoryBottomSheet,
    bool? isOpenCurrentStateBottomSheet,
    bool? isOpenFileBottomSheet,
    int? projectId,
    List<ObjectTypeModel>? objectTypes,
    List<ProjectCategoryModel>? projectCategories,
    List<ObjectConditionModel>? objectConditions,
    // List<PlatformFile>? pickedFiles,
    // List<XFile>? pickedImages,
    List<UploadedFileModel>? uploadedFilesAndImages,
    List<AiConsultant>? aiAgents,
  }) {
    return ShowCreateProjectState(
      currentPage: currentPage ?? this.currentPage,
      isOpenObjectBottomSheet:
          isOpenObjectBottomSheet ?? this.isOpenObjectBottomSheet,
      isOpenCategoryBottomSheet:
          isOpenCategoryBottomSheet ?? this.isOpenCategoryBottomSheet,
      isOpenCurrentStateBottomSheet:
          isOpenCurrentStateBottomSheet ?? this.isOpenCurrentStateBottomSheet,
      isOpenFileBottomSheet:
          isOpenFileBottomSheet ?? this.isOpenFileBottomSheet,
      projectId: projectId ?? this.projectId,
      objectTypes: objectTypes ?? this.objectTypes,
      projectCategories: projectCategories ?? this.projectCategories,
      objectConditions: objectConditions ?? this.objectConditions,
      // pickedFiles: pickedFiles ?? this.pickedFiles,
      // pickedImages: pickedImages ?? this.pickedImages,
      uploadedFilesAndImages:
          uploadedFilesAndImages ?? this.uploadedFilesAndImages,
      aiAgents: aiAgents ?? this.aiAgents,
    );
  }
}

class CreateProjectSuccess extends CreateProjectState {}
