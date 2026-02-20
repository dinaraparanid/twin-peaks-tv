import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/constants/constants.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/home/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/home/home_tab.dart';
import 'package:twin_peaks_tv/feature/home/widget/widget.dart';

@RoutePage()
final class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const tabAnimationDuration = Duration(milliseconds: 300);

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

final class HomeScreenState extends State<HomeScreen> {
  late final tabController = TvTabBarController();
  late final tabFocusScopeNode = FocusScopeNode();
  late final contentFocusScopeNode = FocusScopeNode();

  late var _currentIndex = tabController.selectedIndex;
  var _tabBarHasFocus = false;

  @override
  void initState() {
    tabController.addListener(_tabListener);
    tabFocusScopeNode.addListener(_focusListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(FocusConstants.navigatorDelay, () {
        tabFocusScopeNode.requestFocus();
      });
    });

    super.initState();
  }

  void _tabListener() {
    if (_currentIndex != tabController.selectedIndex) {
      setState(() => _currentIndex = tabController.selectedIndex);
      context.replaceRoute(HomeTab.values[_currentIndex].buildRoute());
    }
  }

  void _focusListener() {
    if (_tabBarHasFocus != tabFocusScopeNode.hasFocus) {
      setState(() => _tabBarHasFocus = tabFocusScopeNode.hasFocus);
    }
  }

  @override
  void dispose() {
    tabController.removeListener(_tabListener);
    tabFocusScopeNode.removeListener(_focusListener);

    tabController.dispose();
    tabFocusScopeNode.dispose();
    contentFocusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => di<HomeBlocFactory>()(),
      child: Stack(
        children: [
          AutoRouter(
            requestFocus: false,
            builder: (context, child) => DpadFocusScope(
              focusScopeNode: contentFocusScopeNode,
              onUp: (_, _, isOutOfScope) {
                if (isOutOfScope) {
                  tabFocusScopeNode.requestFocus();
                }

                return KeyEventResult.handled;
              },
              builder: (_, _) => child,
            ),
          ),

          Align(
            alignment: AppPlatform.isAndroid
                ? Alignment.topLeft
                : Alignment.topCenter,
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: distinctState((x) => x.tabBarOpacity),
              builder: (context, state) => AnimatedOpacity(
                opacity: state.tabBarOpacity,
                duration: const Duration(milliseconds: 300),
                child: switch (AppPlatform.targetPlatform) {
                  AppPlatforms.android => MaterialTabBar(
                    tabController: tabController,
                    tabFocusScopeNode: tabFocusScopeNode,
                    contentFocusNode: contentFocusScopeNode,
                    currentIndex: _currentIndex,
                  ),

                  AppPlatforms.tizen => OneUiTabBar(
                    tabController: tabController,
                    tabFocusScopeNode: tabFocusScopeNode,
                    contentFocusNode: contentFocusScopeNode,
                    currentIndex: _currentIndex,
                  ),

                  AppPlatforms.tvos => throw UnimplementedError(),

                  AppPlatforms.webos => MaterialTabBar(
                    tabController: tabController,
                    tabFocusScopeNode: tabFocusScopeNode,
                    contentFocusNode: contentFocusScopeNode,
                    currentIndex: _currentIndex,
                  ),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
