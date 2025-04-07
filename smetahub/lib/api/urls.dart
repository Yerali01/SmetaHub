part of 'network_api.dart';

///Перечень запросов
abstract class Urls {
  static const String _auth = '/api/auth';
  static const String _project = '/api/project';
  static const String _estimate = '/api/estimate';
  static const String _chat = '/api/chat';

  static const String logOut = '$_auth/logout';
  static const String setPassword = '$_auth/set-password';
  static const String me = '$_auth/me';
  static const String refresh = '$_auth/refresh';
  static const String register = '$_auth/register';
  static const String resetPasswordConfirm = '$_auth/reset-password/confirm';
  static const String resetPasswordRequest = '$_auth/reset-password/request';
  static const String sendVerification = '$_auth/send-verification';
  static const String login = '$_auth/login';
  static const String verifyPhone = '$_auth/verify-phone';
  static const String verifyReset = '$_auth/reset-password/verify';

  static const String createProjectName = '$_project/create';
  static const String selectObjectType = '$_project/update/object-type';
  static const String selectCategory = '$_project/update/project-category';
  static const String selectCurrentState = '$_project/update/object-condition';
  static const String uploadProjectFile = '$_project/files/upload';
  static const String deleteProjectFile = '$_project/files';
  static const String createTechCondition =
      '$_project/technical-conditions/create';

  static const String getProjects = '$_project/projects';
  static const String getAllAgents = '$_chat/agents';
  static const String addAiAgentsToProject = '$_chat/project/add-agent';

  static const String createSmeta = 'api/estimate/create/start';
  static const String getWorkTypes = '$_estimate/work-types';
  static const String addSubspeciesWorkType =
      '$_estimate/add/subspecies-work-type';
  static const String getMaterialTypes = '$_estimate/material-types';
  static const String addMaterialType = '$_estimate/add/material-type';
  static const String addSpecialWish = '$_estimate/add/special-wish';
  static const String createSmetaName = '$_estimate/add/estimate-name';
  static const String getUserEstimates = '$_estimate/estimates';
  static const String getEstimateItems = '$_estimate/estimate';
  static const String updateEstimateItems = '$_estimate/update/estimate-items';
  static const String addEstimateItem = '$_estimate/add/estimate-item';
  static const String generalEstimate = '$_estimate/generate/estimate';

  static const String createChat = '$_chat';
  static const String getAllChats = '$_chat';
  static const String getChat = '$_chat';
  static const String sendMessage = '$_chat/send';
}
