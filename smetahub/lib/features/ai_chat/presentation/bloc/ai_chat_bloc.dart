import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/ai_chat/domain/message_model.dart';
import 'package:smetahub/features/ai_chat/domain/user_chat_model.dart';
import 'package:smetahub/features/home/domain/entity/ai_consultant.dart';
import 'package:smetahub/repository/app_repository.dart';

part 'ai_chat_event.dart';
part 'ai_chat_state.dart';

class AiChatBloc extends Bloc<AiChatEvent, AiChatState> {
  AiChatBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(
          ShowAiChatState(
            aiAgents: [],
            messages: [],
            groupedUserChats: {},
            isLoading: false,
            isDeletChatOverlayOpen: false,
          ),
        ) {
    on<AiChatEvent>((event, emit) {});
    on<CreateNewChatEvent>(_createNewChat);
    on<InitAiChatScreenEvent>(_initAiChatScreen);
    on<GetAllAiAgentsEvent>(_getAllAiAgents);
    on<GetUserChatsEvent>(_getUserChats);
    on<GetChatInfoEvent>(_getChatInfo);
    on<SendMessageEvent>(_sendMessage);
    on<SelectChatAiAgentEvent>(_selectAiAgent);

    on<ChangeChatEvent>(_changeChat);
    on<ShowDeleteChatOverlay>(_showDeleteChatOverlay);
    on<DeleteChatEvent>(_deleteChat);
  }

  final AppRepository _appRepository;

  Future<void> _initAiChatScreen(
    final InitAiChatScreenEvent event,
    final Emitter<AiChatState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    final ShowAiChatState state = this.state as ShowAiChatState;

    final AiConsultant? sAI = _appRepository.aiConsultants.valueOrNull
        ?.firstWhere((AiConsultant agent) {
      return agent.id == event.agentId;
    });

    emit(
      state.copyWith(
        firstMessage: event.message,
        chatId: event.chatId,
        selectedAgentId: event.agentId,
        selectedAiAgent: sAI,
      ),
    );
    add(
      SendMessageEvent(
        chatId: event.chatId,
        content: event.message,
      ),
    );
  }

  Future<void> _selectAiAgent(
    final SelectChatAiAgentEvent event,
    final Emitter<AiChatState> emit,
  ) async {
    final ShowAiChatState state = this.state as ShowAiChatState;
    emit(
      state.copyWith(
        selectedAiAgent: event.aiAgent,
        selectedAgentId: event.aiAgent.id,
      ),
    );
  }

  Future<void> _getAllAiAgents(
    final GetAllAiAgentsEvent event,
    final Emitter<AiChatState> emit,
  ) async {
    final ShowAiChatState state = this.state as ShowAiChatState;
    _appRepository.aiConsultants.stream.listen((value) {
      emit(
        state.copyWith(
          aiAgents: value,
        ),
      );
    });
  }

  Future<void> _getUserChats(
    final GetUserChatsEvent event,
    final Emitter<AiChatState> emit,
  ) async {
    try {
      final ShowAiChatState state = this.state as ShowAiChatState;

      final res = await _appRepository.getUserChats(
        projectId: event.projectId,
      );

      if (res["chats"] != null) {
        List<dynamic> userChats = res["chats"].map(
          (item) {
            return UserChatModel(
              title: item['title'],
              projectId: item['project_id'],
              agentId: item['agent_id'],
              chatId: item['id'],
              messages: item['messages'].map((messageItem) {
                return MessageModel.fromJson(messageItem);
              }).toList(),
              updatedAt: DateTime.parse(item['updated_at']),
            );
          },
        ).toList();

        _appRepository.userChats.add(userChats);

        Map<DateTime, List<dynamic>> groupedUserChats =
            groupChatsByDate(_appRepository.userChats.value);

        emit(
          state.copyWith(
            groupedUserChats: groupedUserChats,
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getUserChats = $e');
    }
  }

  Map<DateTime, List<dynamic>> groupChatsByDate(List<dynamic> userChats) {
    Map<DateTime, List<dynamic>> groupedChats = {};

    for (var chat in userChats) {
      DateTime dateKey = DateTime(
        chat.updatedAt.year,
        chat.updatedAt.month,
        chat.updatedAt.day,
      );

      if (!groupedChats.containsKey(dateKey)) {
        groupedChats[dateKey] = [];
      }

      groupedChats[dateKey]?.add(chat);
    }

    return groupedChats;
  }

  Future<void> _getChatInfo(
    final GetChatInfoEvent event,
    final Emitter<AiChatState> emit,
  ) async {
    try {
      final ShowAiChatState state = this.state as ShowAiChatState;
      final res = await _appRepository.getChat(
        chatId: event.chatId,
      );

      if (res["title"] != null) {
        emit(state.copyWith(
          chatId: event.chatId,
          messages: res["messages"].map((item) {
            return MessageModel(
              chatId: event.chatId,
              content: item["content"],
              role: item["role"],
            );
          }).toList(),
          selectedAgentId: res["agent_id"],
        ));
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getChatInfo = $e');
    }
  }

  Future<void> _changeChat(
    final ChangeChatEvent event,
    final Emitter<AiChatState> emit,
  ) async {
    try {
      add(
        GetChatInfoEvent(chatId: event.chatId),
      );
    } on Exception catch (e) {
      log('Ошибка!!! _changeChat = $e');
    }
  }

  Future<void> _showDeleteChatOverlay(
    final ShowDeleteChatOverlay event,
    final Emitter<AiChatState> emit,
  ) async {
    try {
      final ShowAiChatState state = this.state as ShowAiChatState;

      emit(
        state.copyWith(
          isDeletChatOverlayOpen: !state.isDeletChatOverlayOpen,
        ),
      );
    } on Exception catch (e) {
      log('Ошибка!!! _showDeleteChatOverlay = $e');
    }
  }

  Future<void> _deleteChat(
    final DeleteChatEvent event,
    final Emitter<AiChatState> emit,
  ) async {
    try {
      final ShowAiChatState state = this.state as ShowAiChatState;
      final res = await _appRepository.deleteChat(
        chatId: event.chatId,
      );
      if (res["message"] == "Чат успешно удален") {
        if (state.chatId == event.chatId) {
          add(
            CreateNewChatEvent(
              title: '',
              aiAgentId: 1,
            ),
          );
        }
      }
    } on Exception catch (e) {
      log('Ошибка!!! _deleteChat = $e');
    }
  }

  Future<void> _createNewChat(
    final CreateNewChatEvent event,
    final Emitter<AiChatState> emit,
  ) async {
    try {
      final ShowAiChatState state = this.state as ShowAiChatState;
      final res = await _appRepository.createChat(
        title: 'Новый чат',
        projectId: event.projectId,
        aiAgentId: event.aiAgentId,
      );

      if (res["title"] != null) {
        emit(
          state.copyWith(
            chatId: res["id"],
            messages: [],
            selectedAgentId: res["agent_id"],
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _createChat = $e');
    }
  }

  Future<void> _sendMessage(
    final SendMessageEvent event,
    final Emitter<AiChatState> emit,
  ) async {
    try {
      final ShowAiChatState state = this.state as ShowAiChatState;
      emit(
        state.copyWith(
          messages: state.messages
            ..add(
              MessageModel(
                chatId: event.chatId,
                content: {"text": event.content},
                role: 'user',
              ),
            ),
          isLoading: true,
        ),
      );
      final res = await _appRepository.sendMessage(
        chatId: event.chatId,
        content: event.content,
      );

      if (res["assistant_message"]["content"] != null) {
        emit(
          state.copyWith(
            isLoading: false,
            messages: state.messages
              ..add(
                MessageModel(
                  chatId: event.chatId,
                  content: res["assistant_message"]["content"],
                  role: 'assistant',
                ),
              ),
          ),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _sendMessage = $e');
    }
  }
}
