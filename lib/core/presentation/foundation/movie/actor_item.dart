import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';

const _avatarSize = 72.0;

final class ActorItem extends StatelessWidget {
  const ActorItem({super.key, this.focusNode, required this.actor});

  final FocusNode? focusNode;
  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        AnimatedSelectionBorders(
          focusNode: focusNode,
          shape: BoxShape.circle,
          builder: (context, node) => ClipOval(
            child: CachedNetworkImage(
              imageUrl: actor.thumbnailUrl,
              fit: BoxFit.cover,
              width: _avatarSize,
              height: _avatarSize,
            ),
          ),
        ),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  actor.name,
                  style: context.appTheme.typography.actor.name.copyWith(
                    color: context.appTheme.colors.text.primary,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  actor.character,
                  style: context.appTheme.typography.actor.character.copyWith(
                    color: context.appTheme.colors.text.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
