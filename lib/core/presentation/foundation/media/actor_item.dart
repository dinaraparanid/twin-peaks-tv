import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';

double get _avatarSize => 84.0.s;

final class ActorItem extends StatelessWidget {
  const ActorItem({super.key, this.focusNode, required this.actor});

  final FocusNode? focusNode;
  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4.s,
      children: [
        AnimatedFocusSelectionBorders(
          focusNode: focusNode,
          autoscroll: true,
          shape: BoxShape.circle,
          builder: (context, node) => ClipOval(
            child: AppNetworkImage(
              imageUrl: actor.thumbnailUrl,
              fit: BoxFit.cover,
              width: _avatarSize,
              height: _avatarSize,
            ),
          ),
        ),

        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 108.s),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 2.s,
            children: [
              Text(
                actor.name,
                textAlign: TextAlign.center,
                style: context.appTheme.typography.actor.name.copyWith(
                  color: context.appTheme.colors.text.primary,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  actor.character,
                  textAlign: TextAlign.center,
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
