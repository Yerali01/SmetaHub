part of 'home_bloc.dart';

abstract class HomeState {}

class ShowHomeState extends HomeState {
  ShowHomeState({
    required this.projects,
    required this.userEstimates,
    required this.aiAgents,
    required this.selectedAiAgent,
    required this.showAllProjectsSort,
  });

  final List<ProjectModel> projects;
  final List<EstimateModel> userEstimates;
  final List<AiConsultant> aiAgents;
  final AiConsultant? selectedAiAgent;

  final bool showAllProjectsSort;

  ShowHomeState copyWith(
      {List<ProjectModel>? projects,
      List<EstimateModel>? userEstimates,
      List<AiConsultant>? aiAgents,
      AiConsultant? selectedAiAgent,
      bool? showAllProjectsSort}) {
    return ShowHomeState(
      projects: projects ?? this.projects,
      userEstimates: userEstimates ?? this.userEstimates,
      aiAgents: aiAgents ?? this.aiAgents,
      selectedAiAgent: selectedAiAgent ?? this.selectedAiAgent,
      showAllProjectsSort: showAllProjectsSort ?? this.showAllProjectsSort,
    );
  }
}

class CreateChatSuccessState extends HomeState {
  CreateChatSuccessState({
    required this.agentId,
    required this.chatId,
  });

  final int agentId;
  final int chatId;
  // final AiConsultant selectedAiAgent;
}
