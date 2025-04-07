import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:smetahub/features/ai_chat/presentation/screens/ai_chat_screen.dart';
import 'package:smetahub/features/ai_chat/presentation/screens/ai_chat_wrapper_screen.dart';
import 'package:smetahub/features/app/presentation/app_page.dart';
import 'package:smetahub/features/app/presentation/app_wrapper.dart';
import 'package:smetahub/features/auth/presentation/screens/mobile/sign_in_screen.dart';
import 'package:smetahub/features/auth/presentation/screens/mobile/auth_wrapper_screen.dart';
import 'package:smetahub/features/create_project/presentation/screens/create_project_screen.dart';
import 'package:smetahub/features/create_project/presentation/screens/create_project_wrapper_screen.dart';
import 'package:smetahub/features/create_smeta/presentation/screens/create_smeta_screen.dart';
import 'package:smetahub/features/create_smeta/presentation/screens/create_smeta_wrapper_screen.dart';
import 'package:smetahub/features/home/presentation/screens/all_projects_screen.dart';
import 'package:smetahub/features/home/presentation/screens/home_screen.dart';
import 'package:smetahub/features/home/presentation/screens/home_wrapper_screen.dart';
import 'package:smetahub/features/user_drafts/presentation/screens/user_drafts_screen.dart';
import 'package:smetahub/features/user_drafts/presentation/screens/user_drafts_wrapper_screen.dart';
import 'package:smetahub/features/user_smetas/presentation/screens/create_estimate_item_screen.dart';
import 'package:smetahub/features/user_smetas/presentation/screens/manage_smeta_screen.dart';
import 'package:smetahub/features/user_smetas/presentation/screens/manage_smeta_wrapper_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          initial: true,
          page: AppWrapperRoute.page,
          children: <AutoRoute>[
            AutoRoute(
              initial: true,
              page: AppRoute.page,
              children: <AutoRoute>[
                AutoRoute(
                  initial: true,
                  page: AuthWrapperRoute.page,
                  children: <AutoRoute>[
                    AutoRoute(
                      initial: true,
                      page: SignInRoute.page,
                    ),
                  ],
                ),
                AutoRoute(
                  page: HomeWrapperRoute.page,
                  children: <AutoRoute>[
                    AutoRoute(
                      initial: true,
                      page: HomeRoute.page,
                    ),
                    AutoRoute(
                      page: CreateProjectWrapperRoute.page,
                      children: [
                        AutoRoute(
                          initial: true,
                          page: CreateProjectRoute.page,
                        ),
                      ],
                    ),
                    AutoRoute(
                      page: UserDraftsWrapperRoute.page,
                      children: [
                        AutoRoute(
                          initial: true,
                          page: UserDraftsRoute.page,
                        ),
                      ],
                    ),
                    AutoRoute(
                      page: CreateSmetaWrapperRoute.page,
                      children: [
                        AutoRoute(
                          initial: true,
                          page: CreateSmetaRoute.page,
                        ),
                        AutoRoute(
                          page: ManageSmetaWrapperRoute.page,
                          children: [
                            AutoRoute(
                              initial: true,
                              page: ManageSmetaRoute.page,
                            ),
                            AutoRoute(
                              page: CreateEstimateItemRoute.page,
                            ),
                          ],
                        ),
                      ],
                    ),
                    AutoRoute(
                      page: ManageSmetaWrapperRoute.page,
                      children: [
                        AutoRoute(
                          initial: true,
                          page: ManageSmetaRoute.page,
                        ),
                        AutoRoute(
                          page: CreateEstimateItemRoute.page,
                        ),
                      ],
                    ),
                    AutoRoute(
                      page: AiChatWrapperRoute.page,
                      children: [
                        AutoRoute(
                          initial: true,
                          page: AiChatRoute.page,
                        ),
                      ],
                    ),
                    AutoRoute(
                      page: AllProjectsRoute.page,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}
