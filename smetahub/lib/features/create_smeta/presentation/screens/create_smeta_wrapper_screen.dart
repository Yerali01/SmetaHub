import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/create_smeta/presentation/bloc/create_smeta_bloc.dart';
import 'package:smetahub/repository/app_repository.dart';

@RoutePage()
class CreateSmetaWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const CreateSmetaWrapperScreen({super.key});

  @override
  Widget wrappedRoute(final BuildContext context) {
    return BlocProvider<CreateSmetaBloc>(
      create: (final _) => CreateSmetaBloc(
        appRepository: context.read<AppRepository>(),
      )..add(
          GetProjectsEvent(),
        ),
      child: this,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return const AutoRouter();
  }
}
