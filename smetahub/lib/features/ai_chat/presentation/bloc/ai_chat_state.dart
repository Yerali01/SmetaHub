part of 'ai_chat_bloc.dart';

abstract class AiChatState {}

class AiChatInitial extends AiChatState {}

class ShowAiChatState extends AiChatState {
  ShowAiChatState({
    required this.aiAgents,
    required this.messages,
    this.chatId,
    this.selectedAgentId,
    this.selectedAiAgent,
    this.firstMessage,
    required this.isLoading,
  });

  final List<AiConsultant> aiAgents;
  final List<Message> messages;
  final int? chatId;
  final int? selectedAgentId;
  final AiConsultant? selectedAiAgent;
  final String? firstMessage;
  final bool isLoading;
  ShowAiChatState copyWith({
    List<AiConsultant>? aiAgents,
    List<Message>? messages,
    int? chatId,
    int? selectedAgentId,
    AiConsultant? selectedAiAgent,
    String? firstMessage,
    bool? isLoading,
  }) {
    return ShowAiChatState(
      aiAgents: aiAgents ?? this.aiAgents,
      messages: messages ?? this.messages,
      chatId: chatId ?? this.chatId,
      selectedAgentId: selectedAgentId ?? this.selectedAgentId,
      selectedAiAgent: selectedAiAgent ?? this.selectedAiAgent,
      firstMessage: firstMessage ?? this.firstMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
