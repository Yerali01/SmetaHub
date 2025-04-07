import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/create_project/domain/models/project_model.dart';
import 'package:smetahub/features/home/domain/entity/ai_consultant.dart';
import 'package:smetahub/features/home/domain/entity/estimate_model.dart';
import 'package:smetahub/features/home/domain/entity/unit_model.dart';
import 'package:smetahub/repository/app_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(
          ShowHomeState(
            projects: [],
            userEstimates: [],
            aiAgents: [],
            selectedAiAgent: null,
            showAllProjectsSort: false,
          ),
        ) {
    on<HomeInitEvent>(_homeInit);
    on<GetProjectsEvent>(_getProjects);
    on<GetEstimatesEvent>(_getEstimates);
    on<GetAllAIAgentsEvent>(_getAllAIAgents);
    on<SelectAiAgentEvent>(_selectAiAgent);

    on<CreateChatEvent>(_createChat);

    on<ShowProjectsInHomeEvent>(_showProjectsInHome);
    on<ShowEstimatesInHomeEvent>(_showEstimaesInHome);
  }

  final AppRepository _appRepository;

  Future<void> _homeInit(
    final HomeInitEvent event,
    final Emitter<HomeState> emit,
  ) async {
    final ShowHomeState state = this.state as ShowHomeState;

    _appRepository.userProjects.stream.listen(
      (data) {
        emit(
          state.copyWith(
            projects: data,
          ),
        );
      },
    );
    _appRepository.userEstimates.stream.listen(
      (data) {
        emit(
          state.copyWith(
            userEstimates: data,
          ),
        );
      },
    );
  }

  Future<void> _createChat(
    final CreateChatEvent event,
    final Emitter<HomeState> emit,
  ) async {
    try {
      final ShowHomeState state = this.state as ShowHomeState;
      final res = await _appRepository.createChat(
        title: event.title,
        projectId: event.projectId,
        aiAgentId: event.aiAgentId,
      );

      if (res["title"] != null) {
        emit(
          CreateChatSuccessState(
            agentId: res["agent_id"],
            chatId: res["id"],
          ),
        );
        emit(state);
      }
    } on Exception catch (e) {
      log('Ошибка!!! _createChat = $e');
    }
  }

  Future<void> _selectAiAgent(
    final SelectAiAgentEvent event,
    final Emitter<HomeState> emit,
  ) async {
    final ShowHomeState state = this.state as ShowHomeState;
    emit(
      state.copyWith(
        selectedAiAgent: event.aiAgent,
      ),
    );
  }

  Future<void> _getProjects(
    final GetProjectsEvent event,
    final Emitter<HomeState> emit,
  ) async {
    try {
      final res = await _appRepository.getProjects();

      if (res["projects"] != null) {
        final List<ProjectModel> projects = [];
        for (int i = 0; i < res["projects"].length; i++) {
          projects.add(ProjectModel.fromJson(res["projects"][i]));
        }
        _appRepository.userProjects.add(projects);

        _appRepository.userProjects.stream.listen(
          (data) {
            add(
              ShowProjectsInHomeEvent(
                projects: data,
              ),
            );
          },
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getProjects = $e');
    }
  }

  Future<void> _getEstimates(
    final GetEstimatesEvent event,
    final Emitter<HomeState> emit,
  ) async {
    try {
      final res = await _appRepository.getEstimates();

      if (res["estimates"] != null) {
        final List<EstimateModel> estimates = [];
        final List<UnitModel> units = [];
        for (int i = 0; i < res["estimates"].length; i++) {
          estimates.add(EstimateModel.fromJson(res["estimates"][i]));
        }
        for (int i = 0; i < res["units"].length; i++) {
          units.add(UnitModel.fromJson(res["units"][i]));
        }
        _appRepository.userEstimates.add(estimates);
        _appRepository.units.add(units);

        _appRepository.userEstimates.stream.listen(
          (data) {
            add(
              ShowEstimatesInHomeEvent(
                estimates: data,
              ),
            );
          },
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getProjects = $e');
    }
  }

  Future<void> _showProjectsInHome(
    final ShowProjectsInHomeEvent event,
    final Emitter<HomeState> emit,
  ) async {
    final ShowHomeState state = this.state as ShowHomeState;
    List<ProjectModel> projects = state.projects..addAll(event.projects);
    emit(
      state.copyWith(
        projects: projects,
      ),
    );
  }

  Future<void> _showEstimaesInHome(
    final ShowEstimatesInHomeEvent event,
    final Emitter<HomeState> emit,
  ) async {
    final ShowHomeState state = this.state as ShowHomeState;
    List<EstimateModel> estimates = state.userEstimates
      ..addAll(event.estimates);
    emit(
      state.copyWith(
        userEstimates: estimates,
      ),
    );
  }

  Future<void> _getAllAIAgents(
    final GetAllAIAgentsEvent event,
    final Emitter<HomeState> emit,
  ) async {
    try {
      final ShowHomeState state = this.state as ShowHomeState;
      final res = await _appRepository.getAllAIAgents();
      List<AiConsultant> aiAgents = [];
      if (res != null && res.length > 0) {
        for (int i = 0; i < res.length; i++) {
          aiAgents.add(
            AiConsultant(
              id: res[i]["id"],
              image: res[i]["photo_download_url"],
              name: res[i]["name"],
              isActive: res[i]["is_active"],
            ),
          );
        }
        _appRepository.aiConsultants.add(aiAgents);
        emit(
          state.copyWith(
            aiAgents: aiAgents,
            selectedAiAgent: aiAgents.first,
          ),
        );
        add(
          HomeInitEvent(),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getAllAIAgents = $e');
    }
  }
}
