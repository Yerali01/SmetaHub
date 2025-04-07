import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smetahub/core/services/router/app_router.dart';
import 'package:smetahub/core/theme/theme_dark_mode.dart';
import 'package:smetahub/core/theme/theme_light_mode.dart';
import 'package:smetahub/repository/app_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(final BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return RepositoryProvider<AppRepository>(
      create: (BuildContext context) => AppRepository(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Map Demo',
        theme: lightMode,
        darkTheme: darkMode,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
