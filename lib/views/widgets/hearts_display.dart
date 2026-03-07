// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:words625/application/hearts_provider.dart';
import 'package:words625/views/theme.dart';
import 'package:words625/views/widgets/loader.dart';

class HeartsDisplay extends StatelessWidget {
  const HeartsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HeartsState>(
      stream: context.read<HeartsProvider>().getHeartsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        final heartsState =
            snapshot.data ?? const HeartsState(hearts: HeartsProvider.maxHearts, heartsRefillAt: null);
        final isInfinite = heartsState.hearts >= HeartsProvider.maxHearts &&
            heartsState.heartsRefillAt == null;

        return Tooltip(
          message: isInfinite ? 'Infinite Hearts' : 'Hearts',
          triggerMode: TooltipTriggerMode.tap,
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(VarnamalaTheme.radiusRound),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.favorite_rounded, color: Color(0xFFE53935), size: 20),
                const SizedBox(width: 4),
                if (isInfinite) ...[
                  const Icon(
                    Icons.all_inclusive_rounded,
                    color: Color(0xFFE53935),
                    size: 16,
                  ),
                ] else ...[
                  Text(
                    '${heartsState.hearts}',
                    style: const TextStyle(
                      color: Color(0xFFE53935),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
