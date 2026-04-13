import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/widget/browse/browse_item.dart';

EdgeInsets get _padding => EdgeInsets.symmetric(horizontal: 24.s);

final class SliverBrowseBlock extends StatelessWidget {
  const SliverBrowseBlock({super.key, required this.characters});
  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Padding(padding: _padding, child: const _Label()),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 16.s)),

        SliverPadding(
          padding: _padding,
          sliver: _SliverGrid(characters: characters),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 16.s)),
      ],
    );
  }
}

final class _Label extends StatelessWidget {
  const _Label();

  @override
  Widget build(BuildContext context) {
    return AppLabel(text: context.ln.encyclopedia_browse_label);
  }
}

final class _SliverGrid extends StatelessWidget {
  const _SliverGrid({required this.characters});
  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return SliverTVScrollAdapter(
      sliver: SliverGrid.builder(
        itemCount: characters.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.s,
          crossAxisSpacing: 8.s,
          childAspectRatio: 4,
        ),
        itemBuilder: (_, index) => BrowseItem(character: characters[index]),
      ),
    );
  }
}
