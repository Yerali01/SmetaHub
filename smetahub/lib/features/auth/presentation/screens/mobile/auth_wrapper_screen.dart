import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smetahub/repository/app_repository.dart';

@RoutePage()
class AuthWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const AuthWrapperScreen({super.key});

  @override
  Widget wrappedRoute(final BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (final _) =>
          AuthBloc(appRepository: context.read<AppRepository>()),
      child: this,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return const AutoRouter();
  }
}
