import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

double get _avatarSize => 50.s;

final class RecentItem extends StatelessWidget {
  const RecentItem({super.key, required this.character});
  final Character character;

  @override
  Widget build(BuildContext context) {
    return AnimatedFocusSelectionBox(
      decorationBuilder: (context, animation) => BoxDecoration(
        color: Color.lerp(
          null,
          context.appTheme.colors.encyclopedia.recentFocused,
          animation,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        boxShadow: [
          ?BoxShadow.lerp(
            BoxShadow(color: context.appTheme.colors.transparent),
            BoxShadow(
              offset: Offset(1.s, 1.s),
              blurRadius: 1.s,
              blurStyle: BlurStyle.outer,
            ),
            animation,
          ),
        ],
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
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.s),
                child: ClipOval(
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

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 240.s),
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
                  maxLines: 3,
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
