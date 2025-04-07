import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/create_project/domain/models/project_model.dart';
import 'package:smetahub/features/home/domain/entity/estimate_model.dart';
import 'package:smetahub/repository/app_repository.dart';

part 'user_drafts_event.dart';
part 'user_drafts_state.dart';

class UserDraftsBloc extends Bloc<UserDraftsEvent, UserDraftsState> {
  UserDraftsBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(
          ShowUserDraftsState(
            projects: [],
            estimates: [],
          ),
        ) {
    on<GetDraftProjectsEvent>(_getDraftProjects);
    on<GetDraftEstimatesEvent>(_getDraftEstimates);
  }

  final AppRepository _appRepository;

  Future<void> _getDraftProjects(
    final GetDraftProjectsEvent event,
    final Emitter<UserDraftsState> emit,
  ) async {
    try {
      ShowUserDraftsState state = this.state as ShowUserDraftsState;
      if (_appRepository.userProjects.hasValue == true) {
        List<ProjectModel> projects = _appRepository.userProjects.value;

        emit(
          state.copyWith(
            projects: projects.where((ProjectModel p) {
              return p.status == 'draft';
            }).toList(),
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getDraftProjects = $e');
    }
  }

  Future<void> _getDraftEstimates(
    final GetDraftEstimatesEvent event,
    final Emitter<UserDraftsState> emit,
  ) async {
    try {
      ShowUserDraftsState state = this.state as ShowUserDraftsState;
      if (_appRepository.userEstimates.hasValue == true) {
        List<EstimateModel> estimates = _appRepository.userEstimates.value;

        emit(
          state.copyWith(
            estimates: estimates.where((EstimateModel eM) {
              return eM.status == 'draft';
            }).toList(),
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getDraftEstimates = $e');
    }
  }
}
