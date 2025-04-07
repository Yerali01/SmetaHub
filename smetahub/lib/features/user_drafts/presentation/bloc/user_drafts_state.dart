part of 'user_drafts_bloc.dart';

abstract class UserDraftsState {}

class ShowUserDraftsState extends UserDraftsState {
  final List<ProjectModel> projects;
  final List<EstimateModel> estimates;

  ShowUserDraftsState({
    required this.projects,
    required this.estimates,
  });

  ShowUserDraftsState copyWith({
    List<ProjectModel>? projects,
    List<EstimateModel>? estimates,
  }) {
    return ShowUserDraftsState(
      projects: projects ?? this.projects,
      estimates: estimates ?? this.estimates,
    );
  }
}
