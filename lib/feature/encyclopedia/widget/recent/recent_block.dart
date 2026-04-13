import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/widget/recent/clear_recent_button.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/widget/recent/recent_item.dart';

EdgeInsets get _padding => EdgeInsets.symmetric(horizontal: 24.s);

final class RecentBlock extends StatelessWidget {
  const RecentBlock({super.key, required this.characters});
  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: _padding,
          child: const Row(children: [_Label(), Spacer(), ClearRecentButton()]),
        ),

        SizedBox(height: 16.s),

        _List(characters: characters),
      ],
    );
  }
}

final class _Label extends StatelessWidget {
  const _Label();

  @override
  Widget build(BuildContext context) {
    return AppLabel(text: context.ln.encyclopedia_recent_label);
  }
}

final class _List extends StatelessWidget {
  const _List({required this.characters});
  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.s,
      child: TvListView.separated(
        scrollDirection: Axis.horizontal,
        padding: _padding,
        itemCount: characters.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.s),
        itemBuilder: (_, index) => RecentItem(character: characters[index]),
      ),
    );
  }
}
