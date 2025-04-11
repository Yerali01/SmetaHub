import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/user_smetas/presentation/bloc/create_smeta_item_bloc/create_estimate_item_bloc.dart';
import 'package:smetahub/features/user_smetas/presentation/bloc/manage_smeta_bloc/manage_smeta_bloc.dart';
import 'package:smetahub/repository/app_repository.dart';

@RoutePage()
class ManageSmetaWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const ManageSmetaWrapperScreen({super.key, required this.estimateId});

  final int estimateId;

  @override
  Widget wrappedRoute(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageSmetaBloc>(
          create: (BuildContext context) => ManageSmetaBloc(
            appRepository: context.read<AppRepository>(),
          )..add(
              GetEstimateInfo(estimateId: estimateId),
            ),
          lazy: false,
          child: this,
        ),
        BlocProvider<CreateEstimateItemBloc>(
          create: (BuildContext context) => CreateEstimateItemBloc(
            appRepository: context.read<AppRepository>(),
          )..add(InitCreateEstimateItemEvent()),
          lazy: false,
          child: this,
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return const AutoRouter();
  }
}
