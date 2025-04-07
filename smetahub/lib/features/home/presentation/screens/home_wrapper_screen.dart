import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/home/presentation/bloc/home_bloc.dart';
import 'package:smetahub/repository/app_repository.dart';

@RoutePage()
class HomeWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeWrapperScreen({super.key});

  @override
  Widget wrappedRoute(final BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(
        appRepository: context.read<AppRepository>(),
      )
        ..add(
          GetProjectsEvent(),
        )
        ..add(
          GetAllAIAgentsEvent(),
        )
        ..add(
          GetEstimatesEvent(),
        ),
      lazy: false,
      child: this,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return const AutoRouter();
  }
}
