import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/view_model/stopwatch_view_model.dart';

Widget timerTabView(
    BuildContext context, WidgetRef ref, TabController tabController) {
  final ColorScheme colors = Theme.of(context).colorScheme;
  final stopwatch = ref.watch(addRecordProvider);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          stopwatch.time,
          style: const TextStyle(
            fontSize: 50,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.inventory,
                size: 50,
              ),
              onPressed: () {
                ref.read(addRecordProvider.notifier).sendToRecordTab();
                tabController.animateTo(0);
              },
              style: IconButton.styleFrom(
                foregroundColor: colors.onSecondaryContainer,
                backgroundColor: colors.secondaryContainer,
                disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
                hoverColor: colors.onSecondaryContainer.withOpacity(0.08),
                focusColor: colors.onSecondaryContainer.withOpacity(0.12),
                highlightColor: colors.onSecondaryContainer.withOpacity(0.12),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              icon: const Icon(
                Icons.play_arrow,
                size: 50,
              ),
              onPressed: () {
                ref.read(addRecordProvider.notifier).start();
              },
              style: IconButton.styleFrom(
                foregroundColor: colors.onSecondaryContainer,
                backgroundColor: colors.secondaryContainer,
                disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
                hoverColor: colors.onSecondaryContainer.withOpacity(0.08),
                focusColor: colors.onSecondaryContainer.withOpacity(0.12),
                highlightColor: colors.onSecondaryContainer.withOpacity(0.12),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              icon: const Icon(
                Icons.stop,
                size: 50,
              ),
              onPressed: () {
                ref.read(addRecordProvider.notifier).stop();
              },
              style: IconButton.styleFrom(
                foregroundColor: colors.onSecondaryContainer,
                backgroundColor: colors.secondaryContainer,
                disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
                hoverColor: colors.onSecondaryContainer.withOpacity(0.08),
                focusColor: colors.onSecondaryContainer.withOpacity(0.12),
                highlightColor: colors.onSecondaryContainer.withOpacity(0.12),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
