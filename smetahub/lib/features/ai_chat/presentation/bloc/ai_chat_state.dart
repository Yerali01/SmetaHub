part of 'ai_chat_bloc.dart';

abstract class AiChatState {}

class AiChatInitial extends AiChatState {}

class ShowAiChatState extends AiChatState {
  ShowAiChatState({
    required this.aiAgents,
    required this.messages,
    required this.groupedUserChats,
    this.chatId,
    this.selectedAgentId,
    this.selectedAiAgent,
    this.firstMessage,
    required this.isLoading,
    required this.isDeletChatOverlayOpen,
  });

  final List<AiConsultant> aiAgents;
  final List<dynamic> messages;
  final Map<DateTime, List<dynamic>> groupedUserChats;
  final int? chatId;
  final int? selectedAgentId;
  final AiConsultant? selectedAiAgent;
  final String? firstMessage;
  final bool isLoading;
  final bool isDeletChatOverlayOpen;

  ShowAiChatState copyWith({
    List<AiConsultant>? aiAgents,
    List<dynamic>? messages,
    Map<DateTime, List<dynamic>>? groupedUserChats, // List<UserChatModel>
    int? chatId,
    int? selectedAgentId,
    AiConsultant? selectedAiAgent,
    String? firstMessage,
    bool? isLoading,
    bool? isDeletChatOverlayOpen,
  }) {
    return ShowAiChatState(
      aiAgents: aiAgents ?? this.aiAgents,
      messages: messages ?? this.messages,
      groupedUserChats: groupedUserChats ?? this.groupedUserChats,
      chatId: chatId ?? this.chatId,
      selectedAgentId: selectedAgentId ?? this.selectedAgentId,
      selectedAiAgent: selectedAiAgent ?? this.selectedAiAgent,
      firstMessage: firstMessage ?? this.firstMessage,
      isLoading: isLoading ?? this.isLoading,
      isDeletChatOverlayOpen:
          isDeletChatOverlayOpen ?? this.isDeletChatOverlayOpen,
    );
  }
}
