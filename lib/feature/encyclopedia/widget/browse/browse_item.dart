import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/bloc/bloc.dart';

double get _avatarSize => 50.s;
BorderRadius get _avatarRadius => BorderRadius.all(Radius.circular(12.r));

final class BrowseItem extends StatelessWidget {
  const BrowseItem({super.key, required this.character});
  final Character character;

  @override
  Widget build(BuildContext context) {
    return AnimatedFocusSelectionBox(
      autoscroll: true,
      onSelect: (_, _) {
        context.encyclopediaBloc.add(CharacterClickEvent(character: character));
        return KeyEventResult.handled;
      },
      decorationBuilder: (context, animation, child) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: Gradient.lerp(
            context.appTheme.colors.encyclopedia.browseUnfocused,
            context.appTheme.colors.encyclopedia.browseFocused,
            animation,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          boxShadow: [
            ?BoxShadow.lerp(
              const BoxShadow(),
              BoxShadow(blurRadius: 1.r),
              animation,
            ),
          ],
        ),
        child: child,
      ),
      builder: (context, focusNode, animation) => Row(
        children: [
          SizedBox(width: 8.s),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.s),
            child: DecoratedBox(
              decoration: AnimatedSelectionBorders.buildDecoration(
                context: context,
                animation: animation,
                borderRadius: _avatarRadius,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.s),
                child: ClipRRect(
                  borderRadius: _avatarRadius,
                  child: AppNetworkImage(
                    imageUrl: character.thumbnailUrl,
                    fit: BoxFit.cover,
                    width: _avatarSize,
                    height: _avatarSize,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.s),

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 4.s,
              children: [
                Text(
                  character.name,
                  maxLines: 1,
                  style: context.appTheme.typography.encyclopedia.itemTitle
                      .copyWith(color: context.appTheme.colors.text.primary),
                ),

                Text(
                  character.info,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context
                      .appTheme
                      .typography
                      .encyclopedia
                      .itemDescription
                      .copyWith(color: context.appTheme.colors.text.secondary),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.s),
        ],
      ),
    );
  }
}
