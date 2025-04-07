import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/app/presentation/error_handler_bloc/error_handler_bloc.dart';

@RoutePage()
class AppWrapperPage extends StatelessWidget implements AutoRouteWrapper {
  const AppWrapperPage({super.key});
  @override
  Widget wrappedRoute(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ErrorHandlerBloc>(
          create: (_) => ErrorHandlerBloc()..add(SubscribeErrorHandlerEvent()),
          lazy: false,
        ),
      ],
      child: const AutoRouter(),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return const AutoRouter();
  }
}
