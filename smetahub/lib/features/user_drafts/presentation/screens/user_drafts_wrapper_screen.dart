import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/user_drafts/presentation/bloc/user_drafts_bloc.dart';
import 'package:smetahub/repository/app_repository.dart';

@RoutePage()
class UserDraftsWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const UserDraftsWrapperScreen({super.key});

  @override
  Widget wrappedRoute(final BuildContext context) {
    return BlocProvider<UserDraftsBloc>(
      create: (BuildContext context) => UserDraftsBloc(
        appRepository: context.read<AppRepository>(),
      )
        ..add(
          GetDraftProjectsEvent(),
        )
        ..add(
          GetDraftEstimatesEvent(),
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
