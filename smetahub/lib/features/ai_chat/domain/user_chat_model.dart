class UserChatModel {
  final String title;
  final int? projectId;
  final int agentId;
  final int chatId;
  final List<dynamic> messages;
  final DateTime updatedAt;

  UserChatModel({
    required this.title,
    this.projectId,
    required this.agentId,
    required this.chatId,
    required this.messages,
    required this.updatedAt,
  });
}
