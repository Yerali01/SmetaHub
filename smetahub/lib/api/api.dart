import 'package:smetahub/features/user_smetas/domain/models/estimate_item_model.dart';

/// Интерфейс для Апи. Нужен, чтобы сделать переключатель между
/// оффлайн и онлайн функциями
abstract interface class Api {
  ///
  Future<dynamic> logout({
    required String refreshToken,
  }) async {}

  Future<dynamic> getUserInformation() async {}

  Future<dynamic> accessTokenRefresh({
    required String refreshToken,
  }) async {}

  Future<dynamic> userSignUp({
    String? countryCode,
    required String phoneNumber,
  }) async {}

  Future<dynamic> setPassword({
    required String password,
    required String accessToken,
  }) async {}

  Future<dynamic> userSignIn({
    String? countryCode,
    required String password,
    required String phoneNumber,
  }) async {}

  Future<dynamic> resetPasswordConfirm({
    required String newPassword,
    required String accessToken,
  }) async {}

  Future<dynamic> resetPasswordRequest({
    required String phoneNumber,
  }) async {}

  Future<dynamic> sendVerificationCode({
    required String phoneNumber,
  }) async {}

  Future<dynamic> verifyPhoneNumber({
    required String phoneNumber,
    required String code,
  }) async {}

  Future<dynamic> verifyResetCode({
    required String phoneNumber,
    required String code,
  }) async {}

  Future<dynamic> createProjectName({
    required String name,
    required String accessToken,
  }) async {}

  Future<dynamic> selectObjectType({
    required int projectId,
    required int objectTypeId,
    required String accessToken,
  }) async {}

  Future<dynamic> selectCategory({
    required int projectId,
    required int projectCategoryId,
    required String accessToken,
  }) async {}

  Future<dynamic> selectCurrentState({
    required int projectId,
    required int objectConditionId,
    required String accessToken,
  }) async {}

  Future<dynamic> getProjects({
    required String accessToken,
  }) async {}

  Future<dynamic> getEstimates({
    required String accessToken,
  }) async {}

  Future<dynamic> getEstimateItems({
    required String accessToken,
    required int estimateId,
  }) async {}

  Future<dynamic> updateEstimateItems({
    required String accessToken,
    required int estimateId,
    required List<dynamic> estimateItems,
  }) async {}

  Future<dynamic> addEstimateItem({
    required String accessToken,
    required int estimateId,
    required EstimateItemModel estimateItem,
  }) async {}

  Future<dynamic> uploadProjectFile({
    required int projectId,
    required String file,
    required String accessToken,
  }) async {}

  Future<dynamic> deleteProjectFile({
    required int fileId,
    required String accessToken,
  }) async {}

  Future<dynamic> createTechnicalCondition({
    required int projectId,
    required int area,
    required String accessToken,
  }) async {}

  Future<dynamic> getAllAgents({
    required String accessToken,
  }) async {}

  Future<dynamic> addAiAgentsToProject({
    required int projectId,
    required int aiConsultantId,
    required String accessToken,
  }) async {}

  Future<dynamic> createSmeta({
    required int? projectId,
    required String accessToken,
  }) async {}

  Future<dynamic> getWorkTypes({
    required String accessToken,
  }) async {}

  Future<dynamic> selectSubspeciesWorkType({
    required int estimateId,
    required List<int> subspeciesWorkTypeIds,
    required String accessToken,
  }) async {}

  Future<dynamic> getMaterialTypes({
    required String accessToken,
  }) async {}

  Future<dynamic> addMaterialType({
    required int estimateId,
    required int materialTypeId,
    required String accessToken,
  }) async {}

  Future<dynamic> addSpecialWish({
    required int estimateId,
    required String text,
    required String accessToken,
  }) async {}

  Future<dynamic> createSmetaName({
    required int estimateId,
    required String name,
    required String accessToken,
  }) async {}

  Future<dynamic> generateEstimate({
    required int estimateId,
    required String accessToken,
  }) async {}

  Future<dynamic> createChat({
    required String title,
    int? projectId,
    required int aiAgentId,
    required String accessToken,
  }) async {}

  Future<dynamic> getAllChats({
    required String accessToken,
    int? projectId,
  }) async {}

  Future<dynamic> getChat({
    required String accessToken,
    required int chatId,
  }) async {}

  Future<dynamic> sendMessage({
    required String accessToken,
    required int chatId,
    required String content,
    Object? metadata,
  }) async {}
}
