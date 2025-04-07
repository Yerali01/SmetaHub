import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/ai_chat/presentation/bloc/ai_chat_bloc.dart';
import 'package:smetahub/repository/app_repository.dart';

@RoutePage()
class AiChatWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const AiChatWrapperScreen({
    super.key,
    required this.agentId,
    required this.userInitialText,
    required this.chatId,
  });

  final int agentId;
  final String userInitialText;
  final int chatId;

  @override
  Widget wrappedRoute(final BuildContext context) {
    return BlocProvider<AiChatBloc>(
      create: (final _) => AiChatBloc(
        appRepository: context.read<AppRepository>(),
      )
        ..add(
          InitAiChatScreenEvent(
            message: userInitialText,
            agentId: agentId,
            chatId: chatId,
          ),
        )
        ..add(
          GetAllAiAgentsEvent(),
        ),
      child: const AutoRouter(),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return const AutoRouter();
  }
}
