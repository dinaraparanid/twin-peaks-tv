import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/feature/home/material_tab_bar.dart';
import 'package:twin_peaks_tv/feature/main/main_screen.dart';

@RoutePage()
final class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const tabAnimationDuration = Duration(milliseconds: 300);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

final class _HomeScreenState extends State<HomeScreen> {
  late final _tabController = TvTabBarController();
  late final _tabFocusScopeNode = FocusScopeNode();
  late final _contentFocusNode = FocusNode();

  late var _currentIndex = _tabController.selectedIndex;
  var _tabBarHasFocus = false;

  @override
  void initState() {
    _tabController.addListener(_tabListener);
    _tabFocusScopeNode.addListener(_focusListener);
    super.initState();
  }

  void _tabListener() {
    if (_currentIndex != _tabController.selectedIndex) {
      setState(() => _currentIndex = _tabController.selectedIndex);
    }
  }

  void _focusListener() {
    if (_tabBarHasFocus != _tabFocusScopeNode.hasFocus) {
      setState(() => _tabBarHasFocus = _tabFocusScopeNode.hasFocus);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabListener);
    _tabFocusScopeNode.removeListener(_focusListener);

    _tabController.dispose();
    _tabFocusScopeNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        MaterialTabBar(
          tabController: _tabController,
          tabFocusScopeNode: _tabFocusScopeNode,
          contentFocusNode: _contentFocusNode,
          currentIndex: _currentIndex,
        ),

        Expanded(
          child: Stack(
            children: [
              Align(
                child: DpadFocus(
                  focusNode: _contentFocusNode,
                  onUp: (_, _) {
                    _tabFocusScopeNode.requestFocus();
                    return KeyEventResult.handled;
                  },
                  onLeft: (_, _) {
                    mainNavigationDrawerKey.currentState?.controller
                        .requestFocusOnMenu();

                    return KeyEventResult.handled;
                  },
                  builder: (node) {
                    return Container(
                      width: 500,
                      height: 500,
                      color: node.hasFocus ? Colors.green : Colors.indigo,
                      alignment: Alignment.center,
                      child: const Text('TODO HomeScreen'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
