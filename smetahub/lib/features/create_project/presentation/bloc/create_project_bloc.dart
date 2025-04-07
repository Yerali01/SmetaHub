import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smetahub/features/create_project/domain/models/object_condition_model.dart';
import 'package:smetahub/features/create_project/domain/models/object_type_model.dart';
import 'package:smetahub/features/create_project/domain/models/project_category_model.dart';
import 'package:smetahub/features/create_project/domain/models/project_model.dart';
import 'package:smetahub/features/create_project/domain/models/uploaded_file_model.dart';
import 'package:smetahub/features/home/domain/entity/ai_consultant.dart';
import 'package:smetahub/repository/app_repository.dart';

part 'create_project_event.dart';
part 'create_project_state.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  CreateProjectBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(
          ShowCreateProjectState(
            currentPage: 0,
            projectId: 0,
            isOpenObjectBottomSheet: false,
            isOpenCategoryBottomSheet: false,
            isOpenCurrentStateBottomSheet: false,
            isOpenFileBottomSheet: false,
            objectTypes: [],
            projectCategories: [],
            objectConditions: [],
            uploadedFilesAndImages: [],
            aiAgents: [],
          ),
        ) {
    on<CreateProjectEvent>((event, emit) {});
    on<GoToNextPageEvent>(_goToNextPage);
    on<ShowObjectBottomSheetEvent>(_showObjectBottomSheet);
    on<ShowCategoryBottomSheetEvent>(_showCategoryBottomSheet);
    on<ShowCurrentStateBottomSheetEvent>(_showCurrentStateBottomSheet);
    on<ShowFileBottomSheetEvent>(_showFileBottomSheet);

    on<CreateProjectNameEvent>(_createProjectName);
    on<SelectObjectTypeEvent>(_selectObjectType);
    on<SelectCategoryEvent>(_selectCategory);
    on<SelectCurrentStateEvent>(_selectCurrentState);
    on<CreateTechConditionEvent>(_createTechCondition);
    on<UploadFileEvent>(_uploadFile);

    on<GetAllAIAgentsEvent>(_getAllAIAgents);
    on<AddAiConsultantsEvent>(_addAiConsultants);

    on<ChooseFileEvent>(_chooseFile);
    on<ChooseImageEvent>(_chooseImage);

    on<DeleteFileEvent>(_deleteFile);
  }

  final AppRepository _appRepository;

  Future<void> _createProjectName(
    final CreateProjectNameEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    try {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;
      final res = await _appRepository.createProjectName(
        name: event.name,
      );

      if (res["project_id"] != null) {
        List<ObjectTypeModel> objectTypes = [];
        if (res["object_types"] != null) {
          for (int i = 0; i < res["object_types"].length; i++) {
            objectTypes.add(
              ObjectTypeModel(
                id: res["object_types"][i]["id"],
                name: res["object_types"][i]["name"],
                photoDownloadUrl: res["object_types"][i]["photo_download_url"],
              ),
            );
          }
        }
        _appRepository.objectTypes.add(objectTypes);
        if (_appRepository.userProjectIDs.hasValue == true) {
          _appRepository.userProjectIDs.value.addAll([res["project_id"]]);
        }

        if (_appRepository.userProjects.hasValue == true) {
          _appRepository.userProjects.value.addAll(
            [
              ProjectModel(
                id: res["project_id"],
                name: event.name,
              ),
            ],
          );
        }

        emit(
          state.copyWith(
            currentPage: state.currentPage + 1,
            projectId: res["project_id"],
            objectTypes: objectTypes,
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _createProjectName = $e');
    }
  }

  Future<void> _selectObjectType(
    final SelectObjectTypeEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    try {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;
      final res = await _appRepository.selectObjectType(
        projectId: event.projectId,
        objectTypeId: event.objectTypeId,
      );
      if (res["project_id"] != null) {
        // где то сохранять проекты?

        List<ProjectCategoryModel> categories = [];
        if (res["project_categories"] != null) {
          for (int i = 0; i < res["project_categories"].length; i++) {
            categories.add(ProjectCategoryModel(
              id: res["project_categories"][i]["id"],
              name: res["project_categories"][i]["name"],
            ));
          }
        }

        _appRepository.projectCategories.add(categories);

        List<ObjectConditionModel> objectConditions = [];
        if (res["object_conditions"] != null) {
          for (int i = 0; i < res["object_conditions"].length; i++) {
            objectConditions.add(
              ObjectConditionModel(
                id: res["object_conditions"][i]["id"],
                name: res["object_conditions"][i]["name"],
                image: res["object_conditions"][i]["photo_download_url"],
              ),
            );
          }
        }
        _appRepository.objectConditions.add(objectConditions);

        if (_appRepository.userProjects.hasValue == true) {
          ProjectModel pModel =
              _appRepository.userProjects.value.where((ProjectModel i) {
            return i.id == res["project_id"];
          }).first;

          _appRepository.userProjects.value.removeWhere((ProjectModel i) {
            return i.id == res["project_id"];
          });

          pModel = pModel.copyWith(
              objectType: ObjectTypeModel(
            id: event.objectTypeId,
            name: event.objectName,
            photoDownloadUrl: event.objectImage,
          ));

          _appRepository.userProjects.value.addAll([pModel]);
        }

        emit(
          state.copyWith(
            currentPage: state.currentPage + 1,
            projectCategories: categories,
            objectConditions: objectConditions,
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _selectObjectType = $e');
    }
  }

  Future<void> _selectCategory(
    final SelectCategoryEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    try {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;
      final res = await _appRepository.selectCategory(
        projectId: event.projectId,
        projectCategoryId: event.projectCategoryId,
      );

      if (res["project_id"] != null) {
        List<ObjectConditionModel> objectConditions = [];
        if (res["object_conditions"] != null) {
          for (int i = 0; i < res["object_conditions"].length; i++) {
            objectConditions.add(
              ObjectConditionModel(
                id: res["object_conditions"][i]["id"],
                name: res["object_conditions"][i]["name"],
                image: res["object_conditions"][i]["photo_download_url"],
              ),
            );
          }
        }
        _appRepository.objectConditions.add(objectConditions);

        if (_appRepository.userProjects.hasValue == true) {
          ProjectModel pModel =
              _appRepository.userProjects.value.where((ProjectModel i) {
            return i.id == res["project_id"];
          }).first;

          _appRepository.userProjects.value.removeWhere((ProjectModel i) {
            return i.id == res["project_id"];
          });

          pModel = pModel.copyWith(
            category: ProjectCategoryModel(
              id: event.projectCategoryId,
              name: event.categoryName,
            ),
          );

          _appRepository.userProjects.value.addAll([pModel]);
        }

        emit(
          state.copyWith(
            currentPage: state.currentPage + 1,
            objectConditions: objectConditions,
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _selectCategory = $e');
    }
  }

  Future<void> _selectCurrentState(
    final SelectCurrentStateEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    try {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;
      final res = await _appRepository.selectCurrentState(
        projectId: event.projectId,
        objectConditionId: event.objectConditionId,
      );

      if (res["project_id"] != null) {
        if (_appRepository.userProjects.hasValue == true) {
          ProjectModel pModel =
              _appRepository.userProjects.value.where((ProjectModel i) {
            return i.id == res["project_id"];
          }).first;

          _appRepository.userProjects.value.removeWhere((ProjectModel i) {
            return i.id == res["project_id"];
          });

          pModel = pModel.copyWith(
            objectCondition: ObjectConditionModel(
              id: event.objectConditionId,
              name: event.objectConditionName,
              image: event.objectConditionImage,
            ),
          );

          _appRepository.userProjects.value.addAll([pModel]);
        }

        emit(
          state.copyWith(
            currentPage: state.currentPage + 1,
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _selectCurrentState = $e');
    }
  }

  Future<void> _createTechCondition(
    final CreateTechConditionEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    try {
      final res = await _appRepository.createTechCondition(
        projectId: event.projectId,
        area: event.area,
      );

      if (res["project_id"] != null) {
        if (_appRepository.userProjects.hasValue == true) {
          ProjectModel pModel =
              _appRepository.userProjects.value.where((ProjectModel i) {
            return i.id == res["project_id"];
          }).first;

          _appRepository.userProjects.value.removeWhere((ProjectModel i) {
            return i.id == res["project_id"];
          });

          // pModel = pModel.copyWith(
          //   technicalConditions: TechConditionModel(
          //     id: ,
          //     area: event.area.toDouble(),
          //   ),
          // );

          _appRepository.userProjects.value.addAll([pModel]);
        }
      }
    } on Exception catch (e) {
      log('Ошибка!!! _createTechCondition = $e');
    }
  }

  Future<void> _getAllAIAgents(
    final GetAllAIAgentsEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    try {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;
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
        emit(
          state.copyWith(
            currentPage: state.currentPage + 1,
            aiAgents: aiAgents,
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getAllAIAgents = $e');
    }
  }

  Future<void> _addAiConsultants(
    final AddAiConsultantsEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    try {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;
      bool isAdded = true;
      for (int i = 0; i < event.aiConsultants.length; i++) {
        final res = await _appRepository.addAiConsultants(
          projectId: state.projectId,
          aiConsultantId: event.aiConsultants[i].id,
        );

        if (res["message"] != 'Агент успешно добавлен к проекту') {
          if (_appRepository.userProjects.hasValue == true) {
            ProjectModel pModel =
                _appRepository.userProjects.value.where((ProjectModel i) {
              return i.id == res["project_id"];
            }).first;

            _appRepository.userProjects.value.removeWhere((ProjectModel i) {
              return i.id == res["project_id"];
            });

            pModel = pModel.copyWith(
              aiAgents: event.aiConsultants,
            );

            _appRepository.userProjects.value.addAll([pModel]);
          }

          isAdded = false;
        }
      }

      if (isAdded) {
        emit(
          CreateProjectSuccess(),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _addAiConsultants = $e');
    }
  }

  Future<void> _goToNextPage(
    final GoToNextPageEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    try {
      if (state is ShowCreateProjectState) {
        final ShowCreateProjectState state =
            this.state as ShowCreateProjectState;
        emit(
          state.copyWith(
            currentPage: state.currentPage + 1,
          ),
        );
      }
    } on Exception {
      log('Ошибка!!! _goToNextPage');
    }
  }

  Future<void> _showObjectBottomSheet(
    final ShowObjectBottomSheetEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    if (state is ShowCreateProjectState) {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;

      /// обновляем состояние
      emit(
        state.copyWith(
          isOpenObjectBottomSheet: !state.isOpenObjectBottomSheet,
        ),
      );
    }
  }

  Future<void> _showCategoryBottomSheet(
    final ShowCategoryBottomSheetEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    if (state is ShowCreateProjectState) {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;

      /// обновляем состояние
      emit(
        state.copyWith(
          isOpenCategoryBottomSheet: !state.isOpenCategoryBottomSheet,
        ),
      );
    }
  }

  Future<void> _showCurrentStateBottomSheet(
    final ShowCurrentStateBottomSheetEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    if (state is ShowCreateProjectState) {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;

      /// обновляем состояние
      emit(
        state.copyWith(
          isOpenCurrentStateBottomSheet: !state.isOpenCurrentStateBottomSheet,
        ),
      );
    }
  }

  Future<void> _showFileBottomSheet(
    final ShowFileBottomSheetEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    if (state is ShowCreateProjectState) {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;

      /// обновляем состояние
      emit(
        state.copyWith(
          isOpenFileBottomSheet: !state.isOpenFileBottomSheet,
        ),
      );
    }
  }

  Future<void> _chooseFile(
    final ChooseFileEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    if (state is ShowCreateProjectState) {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;

      final result = await FilePicker.platform.pickFiles();

      /// обновляем состояние
      if (result != null) {
        add(
          UploadFileEvent(
            file: result.files.first.path!,
          ),
        );
        emit(
          state.copyWith(
            isOpenFileBottomSheet: !state.isOpenFileBottomSheet,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isOpenFileBottomSheet: !state.isOpenFileBottomSheet,
          ),
        );
      }
    }
  }

  Future<void> _uploadFile(
    final UploadFileEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    if (state is ShowCreateProjectState) {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;

      final res = await _appRepository.uploadProjectFile(
        projectId: state.projectId,
        file: event.file,
      );
      if (res['project_id'] != null) {
        UploadedFileModel uFile = UploadedFileModel.fromJson(res);

        if (_appRepository.userProjects.hasValue == true) {
          // ProjectModel pModel =
          //     _appRepository.userProjects.value.where((ProjectModel i) {
          //   return i.id == res["project_id"];
          // }).first;

          // _appRepository.userProjects.value.removeWhere((ProjectModel i) {
          //   return i.id == res["project_id"];
          // });

          // List<dynamic> projFiles = pModel.files!..add(
          //   FileModel(

          //   ),
          // );

          // pModel = pModel.copyWith(
          //   files: ,

          // );

          // _appRepository.userProjects.value.addAll([pModel]);
        }

        emit(
          state.copyWith(
            uploadedFilesAndImages: state.uploadedFilesAndImages..add(uFile),
          ),
        );
      }
    }
  }

  Future<void> _deleteFile(
    final DeleteFileEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    if (state is ShowCreateProjectState) {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;
      final res = await _appRepository.deleteProjectFile(
        fileId: event.file.id!,
      );

      if (res['project_id'] != null) {
        emit(
          state.copyWith(
            uploadedFilesAndImages: state.uploadedFilesAndImages
              ..remove(event.file),
          ),
        );
      }
    }
  }

  Future<void> _chooseImage(
    final ChooseImageEvent event,
    final Emitter<CreateProjectState> emit,
  ) async {
    if (state is ShowCreateProjectState) {
      final ShowCreateProjectState state = this.state as ShowCreateProjectState;

      final result = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (result != null) {
        add(
          UploadFileEvent(
            file: result.path,
          ),
        );
        emit(
          state.copyWith(
            isOpenFileBottomSheet: !state.isOpenFileBottomSheet,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isOpenFileBottomSheet: !state.isOpenFileBottomSheet,
          ),
        );
      }
    }
  }
}
