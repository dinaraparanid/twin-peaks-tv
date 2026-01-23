import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/router/app_router.gr.dart';

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
final class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: SplashRoute.page, initial: true),
    ];
  }
}
