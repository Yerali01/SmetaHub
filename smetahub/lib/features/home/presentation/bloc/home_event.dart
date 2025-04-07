part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeInitEvent extends HomeEvent {}

class GetProjectsEvent extends HomeEvent {}

class GetEstimatesEvent extends HomeEvent {}

class GetAllAIAgentsEvent extends HomeEvent {}

class ShowAllProjectsSortEvent extends HomeEvent {}

class ShowProjectsInHomeEvent extends HomeEvent {
  ShowProjectsInHomeEvent({
    required this.projects,
  });
  final List<ProjectModel> projects;
}

class ShowEstimatesInHomeEvent extends HomeEvent {
  ShowEstimatesInHomeEvent({
    required this.estimates,
  });
  final List<EstimateModel> estimates;
}

class SelectAiAgentEvent extends HomeEvent {
  SelectAiAgentEvent({
    required this.aiAgent,
  });
  final AiConsultant aiAgent;
}

class CreateChatEvent extends HomeEvent {
  final String title;
  final int? projectId;
  final int aiAgentId;

  CreateChatEvent({
    required this.title,
    this.projectId,
    required this.aiAgentId,
  });
}
