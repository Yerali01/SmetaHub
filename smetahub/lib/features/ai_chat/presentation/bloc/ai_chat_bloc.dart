import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/ai_chat/domain/message_model.dart';
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
            isLoading: false,
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
  }

  final AppRepository _appRepository;

  Future<void> _initAiChatScreen(
    final InitAiChatScreenEvent event,
    final Emitter<AiChatState> emit,
  ) async {
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
      // final ShowAiChatState state = this.state as ShowAiChatState;
      final res = await _appRepository.getUserChats(
        projectId: event.projectId,
      );

      if (res["chats"] != null) {
        log('GET USER CHATS RES $res');
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getUserChats = $e');
    }
  }

  Future<void> _getChatInfo(
    final GetChatInfoEvent event,
    final Emitter<AiChatState> emit,
  ) async {
    try {
      // final ShowAiChatState state = this.state as ShowAiChatState;
      final res = await _appRepository.getChat(
        chatId: event.chatId,
      );

      if (res["title"] != null) {
        log('GET CHAT INFO RES $res');
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getChatInfo = $e');
    }
  }

  Future<void> _createNewChat(
    final CreateNewChatEvent event,
    final Emitter<AiChatState> emit,
  ) async {
    try {
      final ShowAiChatState state = this.state as ShowAiChatState;
      final res = await _appRepository.createChat(
        title: event.title,
        projectId: event.projectId,
        aiAgentId: event.aiAgentId,
      );

      if (res["title"] != null) {
        log('RES CHAT CREATED $res');
        emit(
          state.copyWith(
            chatId: res["id"],
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
              Message(text: event.content, isUserMessage: true),
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
                Message(
                  text: res["assistant_message"]["content"],
                  isUserMessage: false,
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
