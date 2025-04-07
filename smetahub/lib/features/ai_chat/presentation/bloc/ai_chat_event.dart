part of 'ai_chat_bloc.dart';

abstract class AiChatEvent {}

class GetAllAiAgentsEvent extends AiChatEvent {}

class SelectChatAiAgentEvent extends AiChatEvent {
  final AiConsultant aiAgent;

  SelectChatAiAgentEvent({
    required this.aiAgent,
  });
}

class CreateNewChatEvent extends AiChatEvent {
  final String title;
  final int? projectId;
  final int aiAgentId;

  CreateNewChatEvent({
    required this.title,
    this.projectId,
    required this.aiAgentId,
  });
}

class GetUserChatsEvent extends AiChatEvent {
  final int? projectId;

  GetUserChatsEvent({
    this.projectId,
  });
}

class GetChatInfoEvent extends AiChatEvent {
  final int chatId;

  GetChatInfoEvent({
    required this.chatId,
  });
}

class SendMessageEvent extends AiChatEvent {
  final int chatId;
  final String content;

  SendMessageEvent({
    required this.chatId,
    required this.content,
  });
}

class InitAiChatScreenEvent extends AiChatEvent {
  final String message;
  final int agentId;
  final int chatId;

  InitAiChatScreenEvent({
    required this.message,
    required this.agentId,
    required this.chatId,
  });
}
