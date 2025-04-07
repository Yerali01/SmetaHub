import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/app/presentation/error_handler_bloc/error_handler_bloc.dart';

const routerKey = GlobalObjectKey('router');

@RoutePage()
class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ErrorHandlerBloc, ErrorHandlerState>(
      listener: (context, state) {
        /// при ShowErrorHandlerState показываем ошибку
        if (state is ShowErrorHandlerState) {
          // CustomAwesomeMessage().showMessage(
          //   context: context,
          //   text: state.errorHandlerModel.errorTitle ?? 'unknown error',
          //   type: state.errorHandlerModel.errorType,
          // );
        }
      },
      builder: (context, state) {
        return const AutoRouter(
          key: routerKey,
        );
      },
    );
  }
}
