import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/router/app_router.gr.dart';

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
final class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(
      page: MainRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: EncyclopediaRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
  ];
}
