// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AiChatScreen]
class AiChatRoute extends PageRouteInfo<void> {
  const AiChatRoute({List<PageRouteInfo>? children})
    : super(AiChatRoute.name, initialChildren: children);

  static const String name = 'AiChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AiChatScreen();
    },
  );
}

/// generated route for
/// [AiChatWrapperScreen]
class AiChatWrapperRoute extends PageRouteInfo<AiChatWrapperRouteArgs> {
  AiChatWrapperRoute({
    Key? key,
    required int agentId,
    required String userInitialText,
    required int chatId,
    List<PageRouteInfo>? children,
  }) : super(
         AiChatWrapperRoute.name,
         args: AiChatWrapperRouteArgs(
           key: key,
           agentId: agentId,
           userInitialText: userInitialText,
           chatId: chatId,
         ),
         initialChildren: children,
       );

  static const String name = 'AiChatWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AiChatWrapperRouteArgs>();
      return WrappedRoute(
        child: AiChatWrapperScreen(
          key: args.key,
          agentId: args.agentId,
          userInitialText: args.userInitialText,
          chatId: args.chatId,
        ),
      );
    },
  );
}

class AiChatWrapperRouteArgs {
  const AiChatWrapperRouteArgs({
    this.key,
    required this.agentId,
    required this.userInitialText,
    required this.chatId,
  });

  final Key? key;

  final int agentId;

  final String userInitialText;

  final int chatId;

  @override
  String toString() {
    return 'AiChatWrapperRouteArgs{key: $key, agentId: $agentId, userInitialText: $userInitialText, chatId: $chatId}';
  }
}

/// generated route for
/// [AllProjectsScreen]
class AllProjectsRoute extends PageRouteInfo<void> {
  const AllProjectsRoute({List<PageRouteInfo>? children})
    : super(AllProjectsRoute.name, initialChildren: children);

  static const String name = 'AllProjectsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AllProjectsScreen();
    },
  );
}

/// generated route for
/// [AppPage]
class AppRoute extends PageRouteInfo<void> {
  const AppRoute({List<PageRouteInfo>? children})
    : super(AppRoute.name, initialChildren: children);

  static const String name = 'AppRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppPage();
    },
  );
}

/// generated route for
/// [AppWrapperPage]
class AppWrapperRoute extends PageRouteInfo<void> {
  const AppWrapperRoute({List<PageRouteInfo>? children})
    : super(AppWrapperRoute.name, initialChildren: children);

  static const String name = 'AppWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AppWrapperPage());
    },
  );
}

/// generated route for
/// [AuthWrapperScreen]
class AuthWrapperRoute extends PageRouteInfo<void> {
  const AuthWrapperRoute({List<PageRouteInfo>? children})
    : super(AuthWrapperRoute.name, initialChildren: children);

  static const String name = 'AuthWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AuthWrapperScreen());
    },
  );
}

/// generated route for
/// [CreateEstimateItemScreen]
class CreateEstimateItemRoute extends PageRouteInfo<void> {
  const CreateEstimateItemRoute({List<PageRouteInfo>? children})
    : super(CreateEstimateItemRoute.name, initialChildren: children);

  static const String name = 'CreateEstimateItemRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateEstimateItemScreen();
    },
  );
}

/// generated route for
/// [CreateProjectScreen]
class CreateProjectRoute extends PageRouteInfo<void> {
  const CreateProjectRoute({List<PageRouteInfo>? children})
    : super(CreateProjectRoute.name, initialChildren: children);

  static const String name = 'CreateProjectRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateProjectScreen();
    },
  );
}

/// generated route for
/// [CreateProjectWrapperScreen]
class CreateProjectWrapperRoute extends PageRouteInfo<void> {
  const CreateProjectWrapperRoute({List<PageRouteInfo>? children})
    : super(CreateProjectWrapperRoute.name, initialChildren: children);

  static const String name = 'CreateProjectWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CreateProjectWrapperScreen());
    },
  );
}

/// generated route for
/// [CreateSmetaScreen]
class CreateSmetaRoute extends PageRouteInfo<void> {
  const CreateSmetaRoute({List<PageRouteInfo>? children})
    : super(CreateSmetaRoute.name, initialChildren: children);

  static const String name = 'CreateSmetaRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateSmetaScreen();
    },
  );
}

/// generated route for
/// [CreateSmetaWrapperScreen]
class CreateSmetaWrapperRoute extends PageRouteInfo<void> {
  const CreateSmetaWrapperRoute({List<PageRouteInfo>? children})
    : super(CreateSmetaWrapperRoute.name, initialChildren: children);

  static const String name = 'CreateSmetaWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CreateSmetaWrapperScreen());
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [HomeWrapperScreen]
class HomeWrapperRoute extends PageRouteInfo<void> {
  const HomeWrapperRoute({List<PageRouteInfo>? children})
    : super(HomeWrapperRoute.name, initialChildren: children);

  static const String name = 'HomeWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HomeWrapperScreen());
    },
  );
}

/// generated route for
/// [ManageSmetaScreen]
class ManageSmetaRoute extends PageRouteInfo<void> {
  const ManageSmetaRoute({List<PageRouteInfo>? children})
    : super(ManageSmetaRoute.name, initialChildren: children);

  static const String name = 'ManageSmetaRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ManageSmetaScreen();
    },
  );
}

/// generated route for
/// [ManageSmetaWrapperScreen]
class ManageSmetaWrapperRoute
    extends PageRouteInfo<ManageSmetaWrapperRouteArgs> {
  ManageSmetaWrapperRoute({
    Key? key,
    required int estimateId,
    List<PageRouteInfo>? children,
  }) : super(
         ManageSmetaWrapperRoute.name,
         args: ManageSmetaWrapperRouteArgs(key: key, estimateId: estimateId),
         initialChildren: children,
       );

  static const String name = 'ManageSmetaWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ManageSmetaWrapperRouteArgs>();
      return WrappedRoute(
        child: ManageSmetaWrapperScreen(
          key: args.key,
          estimateId: args.estimateId,
        ),
      );
    },
  );
}

class ManageSmetaWrapperRouteArgs {
  const ManageSmetaWrapperRouteArgs({this.key, required this.estimateId});

  final Key? key;

  final int estimateId;

  @override
  String toString() {
    return 'ManageSmetaWrapperRouteArgs{key: $key, estimateId: $estimateId}';
  }
}

/// generated route for
/// [SignInScreen]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignInScreen();
    },
  );
}

/// generated route for
/// [UserDraftsScreen]
class UserDraftsRoute extends PageRouteInfo<void> {
  const UserDraftsRoute({List<PageRouteInfo>? children})
    : super(UserDraftsRoute.name, initialChildren: children);

  static const String name = 'UserDraftsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserDraftsScreen();
    },
  );
}

/// generated route for
/// [UserDraftsWrapperScreen]
class UserDraftsWrapperRoute extends PageRouteInfo<void> {
  const UserDraftsWrapperRoute({List<PageRouteInfo>? children})
    : super(UserDraftsWrapperRoute.name, initialChildren: children);

  static const String name = 'UserDraftsWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const UserDraftsWrapperScreen());
    },
  );
}
