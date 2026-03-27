import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/feature/settings/widget/info/developer.dart';
import 'package:twin_peaks_tv/feature/settings/widget/info/platform_info.dart';

final class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12.s,
      children: const [PlatformInfo(), Developer()],
    );
  }
}
