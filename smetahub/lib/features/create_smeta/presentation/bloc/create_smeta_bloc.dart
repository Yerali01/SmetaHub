import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/create_project/domain/models/project_model.dart';
import 'package:smetahub/features/create_smeta/domain/models/material_type_model.dart';
import 'package:smetahub/features/create_smeta/domain/models/subspecies_work_type_model.dart';
import 'package:smetahub/features/create_smeta/domain/models/work_type_model.dart';
import 'package:smetahub/features/home/domain/entity/estimate_model.dart';
import 'package:smetahub/repository/app_repository.dart';

part 'create_smeta_event.dart';
part 'create_smeta_state.dart';

class CreateSmetaBloc extends Bloc<CreateSmetaEvent, CreateSmetaState> {
  CreateSmetaBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(
          ShowCreateSmetaState(
            workTypes: [],
            materialTypes: [],
            projects: [],
            currentPage: 0,
            selectedWorkOptions: [],
            estimateId: null,
            projectId: null,
            isEstimateGenerated: true,
          ),
        ) {
    on<GoNextPageEvent>(_goNextPage);
    on<GetProjectsEvent>(_getProjects);

    on<SelectProjectEvent>(_selectProject);
    on<AddWorkOptionEvent>(_addWorkOption);
    // on<AddMaterialEvent>(_addMaterial);
    on<ChooseAllSectionOptionsEvent>(_chooseAllSectionOptions);
    on<ChooseAllEverythingEvent>(_chooseAllEverything);

    on<CreateUserSmetaEvent>(_createUserSmeta);
    on<GetWorkTypesEvent>(_getWorkTypes);
    on<SelectSubspeciesWorkTypeEvent>(_selectSubspeciesWorkType);
    on<GetMaterialTypesEvent>(_getMaterialTypes);
    on<ChooseMaterialEvent>(_chooseMaterial);
    on<AddMaterialTypeEvent>(_addMaterialType);
    on<AddSpecialRequirementsEvent>(_addSpecialRequirements);
    on<CreateSmetaNameEvent>(_createSmetaName);

    on<GenerateEstimateEvent>(_generateEstimate);
  }

  final AppRepository _appRepository;

  Future<void> _goNextPage(
    final GoNextPageEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
    emit(state.copyWith(
      currentPage: state.currentPage + 1,
    ));
  }

  Future<void> _createUserSmeta(
    final CreateUserSmetaEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    try {
      final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
      final res = await _appRepository.createUserSmeta(
        projectId: event.projectId,
      );

      if (res["estimate_id"] != null) {
        if (_appRepository.userEstimates.hasValue == true) {
          _appRepository.userEstimates.value.addAll(
            [
              EstimateModel(
                id: res["estimate_id"],
              ),
            ],
          );
        }

        emit(
          state.copyWith(
            estimateId: res["estimate_id"],
            projectId: event.projectId,
          ),
        );
        add(GetWorkTypesEvent());
      }
    } on Exception catch (e) {
      log('Ошибка!!! _createUserSmeta = $e');
    }
  }

  Future<void> _getWorkTypes(
    final GetWorkTypesEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    try {
      final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
      final res = await _appRepository.getWorkTypes();

      if (res["work_types"].isNotEmpty) {
        final List<WorkTypeModel> workTypes = [];
        for (int i = 0; i < res["work_types"].length; i++) {
          workTypes.add(WorkTypeModel.fromJson(res["work_types"][i]));
        }
        emit(
          state.copyWith(
            workTypes: workTypes,
            currentPage: state.currentPage + 1,
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getWorkTypes = $e');
    }
  }

  Future<void> _selectSubspeciesWorkType(
    final SelectSubspeciesWorkTypeEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    try {
      final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
      if (state.estimateId != null) {
        final List<int> workIDs =
            event.subspeciesWorkTypes.map((SubspeciesWorkTypeModel item) {
          return item.id!;
        }).toList();
        final res = await _appRepository.selectSubspeciesWorkType(
          estimateId: state.estimateId!,
          subspeciesWorkTypeIds: workIDs,
        );

        if (res["estimate_id"] != null) {
          emit(state);
          add(GetMaterialTypesEvent());
        }
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getWorkTypes = $e');
    }
  }

  Future<void> _getMaterialTypes(
    final GetMaterialTypesEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    try {
      final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
      final res = await _appRepository.getMaterialTypes();

      if (res["material_types"].isNotEmpty) {
        log('MATERIALS =======> ${res["material_types"]}');
        List<MaterialTypeModel> materialTypes = [];
        for (int i = 0; i < res["material_types"].length; i++) {
          materialTypes
              .add(MaterialTypeModel.fromJson(res["material_types"][i]));
        }
        emit(
          state.copyWith(
            materialTypes: materialTypes,
            currentPage: state.currentPage + 1,
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getMaterialTypes = $e');
    }
  }

  Future<void> _chooseMaterial(
    final ChooseMaterialEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    try {
      final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
      emit(
        state.copyWith(
          selectedMaterial: event.material,
        ),
      );
    } on Exception catch (e) {
      log('Ошибка!!! _chooseMaterial = $e');
    }
  }

  Future<void> _addMaterialType(
    final AddMaterialTypeEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    try {
      final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
      final res = await _appRepository.addMaterialType(
        estimateId: event.estimateId,
        materialTypeId: event.materialTypeId,
      );

      if (res["estimate_id"] != null) {
        emit(
          state.copyWith(
            currentPage: state.currentPage + 1,
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _addMaterialType = $e');
    }
  }

  Future<void> _addSpecialRequirements(
    final AddSpecialRequirementsEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    try {
      final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
      emit(
        state.copyWith(
          isEstimateGenerated: false,
        ),
      );
      await _appRepository.addSpecialRequirements(
        estimateId: state.estimateId!,
        text: event.text,
      );
    } on Exception catch (e) {
      log('Ошибка!!! _addSpecialRequirements = $e');
    }
  }

  Future<void> _createSmetaName(
    final CreateSmetaNameEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    try {
      final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
      await _appRepository.createSmetaName(
        estimateId: state.estimateId!,
        name: event.name,
      );
    } on Exception catch (e) {
      log('Ошибка!!! _createSmetaName = $e');
    }
  }

  Future<void> _generateEstimate(
    final GenerateEstimateEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    try {
      final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
      final res = await _appRepository.generateEstimate(
        estimateId: event.estimateId,
      );

      if (res['estimate_id'] != null) {
        emit(
          state.copyWith(
            currentPage: state.currentPage + 1,
            isEstimateGenerated: true,
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _generateEstimate = $e');
    }
  }

  Future<void> _addWorkOption(
    final AddWorkOptionEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;

    if (state.selectedWorkOptions.contains(event.workOption)) {
      emit(
        state.copyWith(
          selectedWorkOptions: state.selectedWorkOptions
            ..remove(event.workOption),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedWorkOptions: [...state.selectedWorkOptions, event.workOption],
        ),
      );
    }
  }

  Future<void> _selectProject(
    final SelectProjectEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;

    emit(
      state.copyWith(
        selectedProject: event.project,
      ),
    );
  }

  Future<void> _chooseAllSectionOptions(
    final ChooseAllSectionOptionsEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;

    emit(
      state.copyWith(
        selectedWorkOptions: [
          ...state.selectedWorkOptions,
          ...event.sectionOptions
        ],
      ),
    );
  }

  Future<void> _chooseAllEverything(
    final ChooseAllEverythingEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
    log('STATE STARTED CHOOSING ALL');

    Iterable<SubspeciesWorkTypeModel> allOption =
        state.workTypes.map((WorkTypeModel wTM) {
      return SubspeciesWorkTypeModel(
        id: wTM.id,
        name: wTM.name,
      );
    });

    List<SubspeciesWorkTypeModel> selectedOptio = state.selectedWorkOptions
      ..addAll(allOption);

    emit(
      state.copyWith(
        selectedWorkOptions: selectedOptio,
      ),
    );
  }

  Future<void> _getProjects(
    final GetProjectsEvent event,
    final Emitter<CreateSmetaState> emit,
  ) async {
    try {
      final ShowCreateSmetaState state = this.state as ShowCreateSmetaState;
      if (_appRepository.userProjects.valueOrNull == null) {
        emit(
          state.copyWith(
              // projects: [],
              ),
        );
      } else {
        emit(
          state.copyWith(
            projects: _appRepository.userProjects.value,
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getProjects = $e');
    }
  }
}
