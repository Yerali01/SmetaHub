part of 'create_smeta_bloc.dart';

abstract class CreateSmetaState {}

class ShowCreateSmetaState extends CreateSmetaState {
  final List<ProjectModel> projects;
  final List<MaterialTypeModel> materialTypes;
  final List<WorkTypeModel> workTypes;
  final int currentPage;
  final ProjectModel? selectedProject;
  final List<SubspeciesWorkTypeModel> selectedWorkOptions;
  final MaterialTypeModel? selectedMaterial;

  final int? estimateId;
  final int? projectId;

  final bool isEstimateGenerated;

  ShowCreateSmetaState({
    required this.workTypes,
    required this.materialTypes,
    required this.projects,
    required this.currentPage,
    this.selectedProject,
    required this.selectedWorkOptions,
    this.selectedMaterial,
    required this.estimateId,
    required this.projectId,
    required this.isEstimateGenerated,
  });

  ShowCreateSmetaState copyWith({
    List<WorkTypeModel>? workTypes,
    List<MaterialTypeModel>? materialTypes,
    List<ProjectModel>? projects,
    int? currentPage,
    ProjectModel? selectedProject,
    List<SubspeciesWorkTypeModel>? selectedWorkOptions,
    MaterialTypeModel? selectedMaterial,
    int? estimateId,
    int? projectId,
    bool? isEstimateGenerated,
  }) {
    return ShowCreateSmetaState(
      workTypes: workTypes ?? this.workTypes,
      materialTypes: materialTypes ?? this.materialTypes,
      projects: projects ?? this.projects,
      currentPage: currentPage ?? this.currentPage,
      selectedProject: selectedProject ?? this.selectedProject,
      selectedWorkOptions: selectedWorkOptions ?? this.selectedWorkOptions,
      selectedMaterial: selectedMaterial ?? this.selectedMaterial,
      estimateId: estimateId ?? this.estimateId,
      projectId: projectId ?? this.projectId,
      isEstimateGenerated: isEstimateGenerated ?? this.isEstimateGenerated,
    );
  }
}
