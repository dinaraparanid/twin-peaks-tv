import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/constants/constants.dart';
import 'package:twin_peaks_tv/feature/home/home_tab.dart';
import 'package:twin_peaks_tv/feature/home/widget/material_tab_bar.dart';

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
  late final _contentFocusScopeNode = FocusScopeNode();

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
    _contentFocusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        MaterialTabBar(
          tabController: tabController,
          tabFocusScopeNode: tabFocusScopeNode,
          contentFocusNode: _contentFocusScopeNode,
          currentIndex: _currentIndex,
        ),

        Expanded(
          child: AutoRouter(
            requestFocus: false,
            builder: (context, child) => DpadFocusScope(
              focusScopeNode: _contentFocusScopeNode,
              onUp: (_, _, isOutOfScope) {
                if (isOutOfScope) {
                  tabFocusScopeNode.requestFocus();
                }

                return KeyEventResult.handled;
              },
              builder: (_) => child,
            ),
          ),
        ),
      ],
    );
  }
}
