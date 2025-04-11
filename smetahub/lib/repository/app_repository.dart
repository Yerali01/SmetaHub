// Dart imports:
import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smetahub/api/network_handler.dart';
import 'package:smetahub/core/models/error_handler_model.dart';
import 'package:smetahub/features/create_project/domain/models/object_condition_model.dart';
import 'package:smetahub/features/create_project/domain/models/object_type_model.dart';
import 'package:smetahub/features/create_project/domain/models/project_category_model.dart';
import 'package:smetahub/features/create_project/domain/models/project_model.dart';
import 'package:smetahub/features/create_smeta/domain/models/work_type_model.dart';
import 'package:smetahub/features/home/domain/entity/ai_consultant.dart';
import 'package:smetahub/features/home/domain/entity/estimate_model.dart';
import 'package:smetahub/features/home/domain/entity/unit_model.dart';
import 'package:smetahub/features/user_smetas/domain/models/estimate_item_model.dart';

/// Типы состояний при авторизации
enum AuthStateEnum { wait, loading, loaded, success, successRecovery, fail }

class AppRepository {
  /// [_networkHandler] Для получения данных
  final NetworkHandler _networkHandler = NetworkHandler();

  /// [errorHandlerState] обработчик ошибок на который подписан болок обернутый поверх всего приложения
  BehaviorSubject<ErrorHandlerModel> errorHandlerState =
      BehaviorSubject<ErrorHandlerModel>();

  /// [accessToken] токен авторизации.
  BehaviorSubject<String> accessToken = BehaviorSubject<String>();
  BehaviorSubject<String> refreshToken = BehaviorSubject<String>();

  /// проекты пользователя для главного экрана
  BehaviorSubject<List<ProjectModel>> userProjects =
      BehaviorSubject<List<ProjectModel>>();

  BehaviorSubject<List<EstimateModel>> userEstimates =
      BehaviorSubject<List<EstimateModel>>();

  BehaviorSubject<List<dynamic>> userChats = BehaviorSubject<List<dynamic>>();

  BehaviorSubject<List<UnitModel>> units = BehaviorSubject<List<UnitModel>>();
  BehaviorSubject<List<WorkTypeModel>> workTypes =
      BehaviorSubject<List<WorkTypeModel>>();

  BehaviorSubject<List<int>> userProjectIDs = BehaviorSubject<List<int>>();

  /// типы объектов
  BehaviorSubject<List<ObjectTypeModel>> objectTypes =
      BehaviorSubject<List<ObjectTypeModel>>();

  /// категории проектов
  BehaviorSubject<List<ProjectCategoryModel>> projectCategories =
      BehaviorSubject<List<ProjectCategoryModel>>();

  BehaviorSubject<List<ObjectConditionModel>> objectConditions =
      BehaviorSubject<List<ObjectConditionModel>>();

  BehaviorSubject<List<AiConsultant>> aiConsultants =
      BehaviorSubject<List<AiConsultant>>();

  // / [userInfo] информация о пользователе.
  // BehaviorSubject<UserModel> userInfo = BehaviorSubject<UserModel>();

  // void _showDioErr(DioException e) {
  //   try {
  //     final String err = (e.response?.data['message'] != null)
  //         ? (e.response!.data['message'].toString())
  //         : e.response!.data['detail'].toString() /*e.message.toString()*/;
  //     errorHandlerState.add(ErrorHandlerModel(errorTitle: err));
  //   } catch (_) {
  //     errorHandlerState
  //         .add(ErrorHandlerModel(errorTitle: e.response?.data.toString()));
  //   }
  // }

  Future<void> userSignUp({
    // required String phoneNumber,
    required String email,
  }) async {
    try {
      await _networkHandler.userSignUp(
        email: email,
      );
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => userSignUp ',
      ));
      rethrow;
    }
  }

  Future<dynamic> setPassword({
    required String password,
  }) async {
    try {
      log('ACCESS TOKEN ${accessToken.valueOrNull} <=');
      if (accessToken.valueOrNull != null) {
        return await _networkHandler.setPassword(
          password: password,
          accessToken: accessToken.value,
        );
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => setPassword ',
      ));
      rethrow;
    }
  }

  Future<dynamic> userSignIn({
    // required String phoneNumber,
    required String email,
    required String password,
  }) async {
    // try {
    return await _networkHandler.userSignIn(
      password: password,
      email: email,
    );
    // } on DioException catch (_) {
    //   errorHandlerState.add(
    //     ErrorHandlerModel(
    //       errorTitle: 'AppRepository => userSignIn ',
    //     ),
    //   );
    //   rethrow;
    // }
  }

  // Future<void> getUserInformation({
  //   required String token,
  // }) async {
  //   try {
  //     await _networkHandler.getUserInformation(
  //       token
  //     );
  //   } on DioException catch (_) {
  //     errorHandlerState.add(ErrorHandlerModel(
  //       errorTitle: 'AppRepository => userSignIn ',
  //     ));
  //     rethrow;
  //   }
  // }

  /// Отправка кода для регистрации - send-verification
  Future<void> sendVerificationCode({
    // required String phoneNumber,
    required String email,
  }) async {
    try {
      await _networkHandler.sendVerificationCode(email: email);
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => sendVerificationCode ',
      ));
      rethrow;
    }
  }

  Future<dynamic> verifySignUpPhone({
    // required String phoneNumber,
    required String email,
    required String code,
  }) async {
    try {
      return await _networkHandler.verifyPhoneNumber(
        email: email,
        code: code,
      );
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => verifySignUpPhone ',
      ));
      rethrow;
    }
  }

  Future<dynamic> verifyResetCode({
    required String code,
    // required String phoneNumber,
    required String email,
  }) async {
    try {
      return await _networkHandler.verifyResetCode(
        code: code,
        email: email,
      );
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => verifyResetCode ',
      ));
      rethrow;
    }
  }

  Future<dynamic> resetPasswordRequest({
    // required String phoneNumber,
    required String email,
  }) async {
    try {
      final message = await _networkHandler.resetPasswordRequest(
        // phoneNumber: phoneNumber,
        email: email,
      );

      return message;
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => resetPasswordRequest ',
      ));
      rethrow;
    }
  }

  Future<dynamic> resetPasswordConfirm({
    required String newPassword,
    required String accessToken,
  }) async {
    try {
      final message = await _networkHandler.resetPasswordConfirm(
        newPassword: newPassword,
        accessToken: accessToken,
      );

      return message;
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => resetPasswordConfirm ',
      ));
      rethrow;
    }
  }

  Future<void> logout({required String refreshToken}) async {
    try {
      await _networkHandler.logout(refreshToken: refreshToken);
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => logout ',
      ));
      rethrow;
    }
  }

  Future<void> updateAccessToken({required String refreshToken}) async {
    try {
      final token = await _networkHandler.accessTokenRefresh(refreshToken);
      accessToken.add(token);
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => updateAccessToken ',
      ));
      rethrow;
    }
  }

  Future<dynamic> createProjectName({
    required String name,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.createProjectName(
          name: name,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => createProjectName ',
      ));
      rethrow;
    }
  }

  Future<dynamic> selectObjectType({
    required int projectId,
    required int objectTypeId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.selectObjectType(
          projectId: projectId,
          objectTypeId: objectTypeId,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => selectObjectType ',
      ));
      rethrow;
    }
  }

  Future<dynamic> selectCategory({
    required int projectId,
    required int projectCategoryId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.selectCategory(
          projectId: projectId,
          projectCategoryId: projectCategoryId,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => selectCategory ',
      ));
      rethrow;
    }
  }

  Future<dynamic> selectCurrentState({
    required int projectId,
    required int objectConditionId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.selectCurrentState(
          projectId: projectId,
          objectConditionId: objectConditionId,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => selectCurrentState ',
      ));
      rethrow;
    }
  }

  Future<dynamic> createTechCondition({
    required int projectId,
    required int area,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.createTechCondition(
          projectId: projectId,
          area: area,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => createTechCondition ',
      ));
      rethrow;
    }
  }

  Future<dynamic> getAllAIAgents() async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.getAIAgents(
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => getAllAIAgents ',
      ));
      rethrow;
    }
  }

  Future<dynamic> addAiConsultants({
    required int projectId,
    required int aiConsultantId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.addAiConsultants(
          projectId: projectId,
          aiConsultantId: aiConsultantId,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => addAiConsultants ',
      ));
      rethrow;
    }
  }

  Future<dynamic> uploadProjectFile({
    required int projectId,
    required String file,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
      } else {
        final message = await _networkHandler.uploadProjectFile(
          projectId: projectId,
          file: file,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => uploadProjectFiles ',
      ));
      rethrow;
    }
  }

  Future<dynamic> deleteProjectFile({
    required int fileId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
      } else {
        final message = await _networkHandler.deleteProjectFile(
          fileId: fileId,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => deleteProjectFile ',
      ));
      rethrow;
    }
  }

  Future<dynamic> getProjects() async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.getProjects(
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => getProjects ',
      ));
      rethrow;
    }
  }

  Future<dynamic> getEstimates() async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.getEstimates(
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => getEstimates ',
      ));
      rethrow;
    }
  }

  Future<dynamic> getEstimateInfo({
    required int estimateId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.getEstimateInfo(
          accessToken: accessToken.value,
          estimateId: estimateId,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => getEstimateInfo ',
      ));
      rethrow;
    }
  }

  Future<dynamic> updateEstimateItems({
    required int estimateId,
    required List<dynamic> estimateItems,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.updateEstimateItems(
          accessToken: accessToken.value,
          estimateId: estimateId,
          estimateItems: estimateItems,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => updateEstimateItems ',
      ));
      rethrow;
    }
  }

  Future<dynamic> addEstimateItem({
    required int estimateId,
    required EstimateItemModel estimateItem,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.addEstimateItem(
          accessToken: accessToken.value,
          estimateId: estimateId,
          estimateItem: estimateItem,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => addEstimateItem ',
      ));
      rethrow;
    }
  }

  Future<dynamic> createUserSmeta({
    required int? projectId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.createUserSmeta(
          projectId: projectId,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => createUserSmeta ',
      ));
      rethrow;
    }
  }

  Future<dynamic> getWorkTypes() async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.getWorkTypes(
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => getWorkTypes ',
      ));
      rethrow;
    }
  }

  Future<dynamic> selectSubspeciesWorkType({
    required int estimateId,
    required List<int> subspeciesWorkTypeIds,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.selectSubspeciesWorkType(
          estimateId: estimateId,
          subspeciesWorkTypeIds: subspeciesWorkTypeIds,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => selectSubspeciesWorkType ',
      ));
      rethrow;
    }
  }

  Future<dynamic> getMaterialTypes() async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.getMaterialTypes(
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => getMaterialTypes ',
      ));
      rethrow;
    }
  }

  Future<dynamic> addMaterialType({
    required int estimateId,
    required int materialTypeId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.addMaterialType(
          estimateId: estimateId,
          materialTypeId: materialTypeId,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => addMaterialType ',
      ));
      rethrow;
    }
  }

  Future<dynamic> addSpecialRequirements({
    required int estimateId,
    required String text,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.addSpecialRequirements(
          estimateId: estimateId,
          text: text,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => addSpecialRequirements ',
      ));
      rethrow;
    }
  }

  Future<dynamic> createSmetaName({
    required int estimateId,
    required String name,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.createSmetaName(
          estimateId: estimateId,
          name: name,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => createSmetaName ',
      ));
      rethrow;
    }
  }

  Future<dynamic> generateEstimate({
    required int estimateId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.generateEstimate(
          estimateId: estimateId,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => createSmetaName ',
      ));
      rethrow;
    }
  }

  Future<dynamic> createChat({
    required String title,
    required int? projectId,
    required int aiAgentId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.createChat(
          title: title,
          projectId: projectId,
          aiAgentId: aiAgentId,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => createChat ',
      ));
      rethrow;
    }
  }

  Future<dynamic> deleteChat({
    required int chatId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.deleteChat(
            chatId: chatId, accessToken: accessToken.value);
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => deleteChat ',
      ));
      rethrow;
    }
  }

  Future<dynamic> getUserChats({
    required int? projectId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.getUserChats(
          projectId: projectId,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => getUserChats ',
      ));
      rethrow;
    }
  }

  Future<dynamic> getChat({
    required int chatId,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.getChat(
          chatId: chatId,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => getChat ',
      ));
      rethrow;
    }
  }

  Future<dynamic> sendMessage({
    required int chatId,
    required String content,
  }) async {
    try {
      if (accessToken.valueOrNull == null) {
        //refresh token
      } else {
        final message = await _networkHandler.sendMessage(
          chatId: chatId,
          content: content,
          accessToken: accessToken.value,
        );
        return message;
      }
    } on DioException catch (_) {
      errorHandlerState.add(ErrorHandlerModel(
        errorTitle: 'AppRepository => sendMessage ',
      ));
      rethrow;
    }
  }
}
