import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tv_plus/foundation/dpad/dpad.dart';
import 'package:twin_peaks_tv/feature/main/main_screen.dart';

@RoutePage()
final class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: DpadFocus(
            autofocus: true,
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
    );
  }
}
