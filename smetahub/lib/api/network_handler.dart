// Project imports:
import 'dart:async';

import 'package:smetahub/api/network_api.dart';
import 'package:smetahub/features/user_smetas/domain/models/estimate_item_model.dart';

class NetworkHandler {
  NetworkHandler() {
    _networkApi = NetworkApi();
  }

  late final NetworkApi _networkApi;

  Future<dynamic> accessTokenRefresh(String refreshToken) async {
    return _networkApi.accessTokenRefresh(
      refreshToken: refreshToken,
    );
  }

  // Future<dynamic> getToken({
  //   String? countryCode,
  //   required String password,
  //   required String phoneNumber,
  // }) async {
  //   return _networkApi.getToken(
  //     countryCode: countryCode,
  //     password: password,
  //     phoneNumber: phoneNumber,
  //   );
  // }

  Future<void> logout({
    required String refreshToken,
  }) async {
    _networkApi.logout(refreshToken: refreshToken);
  }

  Future<dynamic> setPassword({
    required String password,
    required String accessToken,
  }) async {
    return _networkApi.setPassword(
      password: password,
      accessToken: accessToken,
    );
  }

  Future<dynamic> resetPasswordConfirm({
    required String newPassword,
    required String accessToken,
  }) async {
    return _networkApi.resetPasswordConfirm(
      newPassword: newPassword,
      accessToken: accessToken,
    );
  }

  Future<dynamic> resetPasswordRequest({
    required String phoneNumber,
  }) async {
    return _networkApi.resetPasswordRequest(
      phoneNumber: phoneNumber,
    );
  }

  Future<dynamic> sendVerificationCode({required String phoneNumber}) async {
    return _networkApi.sendVerificationCode(
      phoneNumber: phoneNumber,
    );
  }

  Future<void> userSignUp({
    String? countryCode,
    // required String password,
    required String phoneNumber,
  }) async {
    await _networkApi.userSignUp(
      // password: password,
      phoneNumber: phoneNumber,
    );
  }

  Future<dynamic> userSignIn({
    String? countryCode,
    required String password,
    required String phoneNumber,
  }) async {
    return await _networkApi.userSignIn(
      password: password,
      phoneNumber: phoneNumber,
    );
  }

  Future<dynamic> verifyPhoneNumber({
    required String phoneNumber,
    required String code,
  }) async {
    return await _networkApi.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      code: code,
    );
  }

  Future<dynamic> verifyResetCode({
    required String code,
    required String phoneNumber,
  }) async {
    return await _networkApi.verifyResetCode(
      code: code,
      phoneNumber: phoneNumber,
    );
  }

  Future<dynamic> createProjectName({
    required String name,
    required String accessToken,
  }) async {
    return await _networkApi.createProjectName(
      name: name,
      accessToken: accessToken,
    );
  }

  Future<dynamic> selectObjectType({
    required int projectId,
    required int objectTypeId,
    required String accessToken,
  }) async {
    return await _networkApi.selectObjectType(
      projectId: projectId,
      objectTypeId: objectTypeId,
      accessToken: accessToken,
    );
  }

  Future<dynamic> selectCategory({
    required int projectId,
    required int projectCategoryId,
    required String accessToken,
  }) async {
    return await _networkApi.selectCategory(
      projectId: projectId,
      projectCategoryId: projectCategoryId,
      accessToken: accessToken,
    );
  }

  Future<dynamic> selectCurrentState({
    required int projectId,
    required int objectConditionId,
    required String accessToken,
  }) async {
    return await _networkApi.selectCurrentState(
      projectId: projectId,
      objectConditionId: objectConditionId,
      accessToken: accessToken,
    );
  }

  Future<dynamic> createTechCondition({
    required int projectId,
    required int area,
    required String accessToken,
  }) async {
    return await _networkApi.createTechnicalCondition(
      projectId: projectId,
      area: area,
      accessToken: accessToken,
    );
  }

  Future<dynamic> getAIAgents({
    required String accessToken,
  }) async {
    return await _networkApi.getAllAgents(
      accessToken: accessToken,
    );
  }

  Future<dynamic> addAiConsultants({
    required int projectId,
    required int aiConsultantId,
    required String accessToken,
  }) async {
    return await _networkApi.addAiAgentsToProject(
      projectId: projectId,
      aiConsultantId: aiConsultantId,
      accessToken: accessToken,
    );
  }

  Future<dynamic> uploadProjectFile({
    required int projectId,
    required String file,
    required String accessToken,
  }) async {
    return await _networkApi.uploadProjectFile(
      projectId: projectId,
      file: file,
      accessToken: accessToken,
    );
  }

  Future<dynamic> deleteProjectFile({
    required int fileId,
    required String accessToken,
  }) async {
    return await _networkApi.deleteProjectFile(
      fileId: fileId,
      accessToken: accessToken,
    );
  }

  Future<dynamic> getProjects({
    required String accessToken,
  }) async {
    return await _networkApi.getProjects(
      accessToken: accessToken,
    );
  }

  Future<dynamic> getEstimates({
    required String accessToken,
  }) async {
    return await _networkApi.getEstimates(
      accessToken: accessToken,
    );
  }

  Future<dynamic> getEstimateInfo({
    required String accessToken,
    required int estimateId,
  }) async {
    return await _networkApi.getEstimateItems(
      accessToken: accessToken,
      estimateId: estimateId,
    );
  }

  Future<dynamic> updateEstimateItems({
    required String accessToken,
    required int estimateId,
    required List<dynamic> estimateItems,
  }) async {
    return await _networkApi.updateEstimateItems(
      accessToken: accessToken,
      estimateId: estimateId,
      estimateItems: estimateItems,
    );
  }

  Future<dynamic> addEstimateItem({
    required String accessToken,
    required int estimateId,
    required EstimateItemModel estimateItem,
  }) async {
    return await _networkApi.addEstimateItem(
      accessToken: accessToken,
      estimateId: estimateId,
      estimateItem: estimateItem,
    );
  }

  Future<dynamic> createUserSmeta({
    required int? projectId,
    required String accessToken,
  }) async {
    return await _networkApi.createSmeta(
      projectId: projectId,
      accessToken: accessToken,
    );
  }

  Future<dynamic> getWorkTypes({
    required String accessToken,
  }) async {
    return await _networkApi.getWorkTypes(
      accessToken: accessToken,
    );
  }

  Future<dynamic> selectSubspeciesWorkType({
    required int estimateId,
    required List<int> subspeciesWorkTypeIds,
    required String accessToken,
  }) async {
    return await _networkApi.selectSubspeciesWorkType(
      estimateId: estimateId,
      subspeciesWorkTypeIds: subspeciesWorkTypeIds,
      accessToken: accessToken,
    );
  }

  Future<dynamic> getMaterialTypes({
    required String accessToken,
  }) async {
    return await _networkApi.getMaterialTypes(
      accessToken: accessToken,
    );
  }

  Future<dynamic> addMaterialType({
    required int estimateId,
    required int materialTypeId,
    required String accessToken,
  }) async {
    return await _networkApi.addMaterialType(
      estimateId: estimateId,
      materialTypeId: materialTypeId,
      accessToken: accessToken,
    );
  }

  Future<dynamic> addSpecialRequirements({
    required int estimateId,
    required String text,
    required String accessToken,
  }) async {
    return await _networkApi.addSpecialWish(
      estimateId: estimateId,
      text: text,
      accessToken: accessToken,
    );
  }

  Future<dynamic> createSmetaName({
    required int estimateId,
    required String name,
    required String accessToken,
  }) async {
    return await _networkApi.createSmetaName(
      estimateId: estimateId,
      name: name,
      accessToken: accessToken,
    );
  }

  Future<dynamic> generateEstimate({
    required int estimateId,
    required String accessToken,
  }) async {
    return await _networkApi.generateEstimate(
      estimateId: estimateId,
      accessToken: accessToken,
    );
  }

  Future<dynamic> createChat({
    required String title,
    required int? projectId,
    required int aiAgentId,
    required String accessToken,
  }) async {
    return await _networkApi.createChat(
      title: title,
      projectId: projectId,
      aiAgentId: aiAgentId,
      accessToken: accessToken,
    );
  }

  Future<dynamic> getUserChats({
    required int? projectId,
    required String accessToken,
  }) async {
    return await _networkApi.getAllChats(
      projectId: projectId,
      accessToken: accessToken,
    );
  }

  Future<dynamic> getChat({
    required int chatId,
    required String accessToken,
  }) async {
    return await _networkApi.getChat(
      chatId: chatId,
      accessToken: accessToken,
    );
  }

  Future<dynamic> sendMessage({
    required int chatId,
    required String content,
    required String accessToken,
  }) async {
    return await _networkApi.sendMessage(
      chatId: chatId,
      content: content,
      accessToken: accessToken,
    );
  }
}
