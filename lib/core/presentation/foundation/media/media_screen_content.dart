import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/utils/ext/key_ext.dart';

final class MediaScreenContent extends StatelessWidget {
  const MediaScreenContent({
    super.key,
    required this.scrollController,
    required this.wallpaper,
    required this.properties,
    required this.title,
    required this.infoInteraction,
    this.carousel,
    required this.cast,
    required this.sliverContent,
  });

  final ScrollController scrollController;
  final Widget? wallpaper;
  final Widget properties;
  final Widget title;
  final Widget infoInteraction;
  final Widget? carousel;
  final Widget cast;
  final Widget sliverContent;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: _Info(
            wallpaper: wallpaper,
            properties: properties,
            title: title,
            infoInteraction: infoInteraction,
            carousel: carousel,
            cast: cast,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          sliver: sliverContent,
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

final class _Info extends StatefulWidget {
  const _Info({
    required this.wallpaper,
    required this.properties,
    required this.title,
    required this.infoInteraction,
    required this.carousel,
    required this.cast,
  });

  final Widget? wallpaper;
  final Widget properties;
  final Widget title;
  final Widget infoInteraction;
  final Widget? carousel;
  final Widget cast;

  @override
  State<StatefulWidget> createState() => _InfoState();
}

final class _InfoState extends State<_Info> {
  final _infoContainerKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {}); // init info container size
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: switch (Platform.isAndroid) {
            true => Alignment.topRight,
            _ => Alignment.topCenter,
          },
          child: widget.wallpaper,
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Flexible(
                    key: _infoContainerKey,
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 120),
                        widget.properties,
                        widget.title,
                        const SizedBox(height: 8),
                        widget.infoInteraction,
                      ],
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: switch (widget.carousel) {
                      null => const SizedBox(),
                      final carousel => Container(
                        height: _infoContainerKey.size?.height,
                        alignment: Alignment.bottomRight,
                        padding: const EdgeInsets.only(left: 64),
                        child: carousel,
                      ),
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            widget.cast,
          ],
        ),
      ],
    );
  }
}
