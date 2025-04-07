import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/create_project/presentation/bloc/create_project_bloc.dart';
import 'package:smetahub/repository/app_repository.dart';

@RoutePage()
class CreateProjectWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const CreateProjectWrapperScreen({super.key});

  @override
  Widget wrappedRoute(final BuildContext context) {
    return BlocProvider<CreateProjectBloc>(
      create: (final _) =>
          CreateProjectBloc(appRepository: context.read<AppRepository>()),
      child: this,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return const AutoRouter();
  }
}
