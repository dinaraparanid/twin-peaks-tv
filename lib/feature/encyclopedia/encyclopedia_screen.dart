import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/bloc/bloc.dart';

@RoutePage()
final class EncyclopediaScreen extends StatelessWidget {
  const EncyclopediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<EncyclopediaBlocFactory>()(),
      child: const Text('TODO: EncyclopediaScreen'),
    );
  }
}
