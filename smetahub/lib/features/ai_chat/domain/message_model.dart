class MessageModel {
  final int chatId;
  final Map<String, dynamic> content;
  final String role;

  MessageModel({
    required this.chatId,
    required this.content,
    required this.role,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      chatId: json['chat_id'],
      content: json['content'],
      role: json['role'],
    );
  }
}
