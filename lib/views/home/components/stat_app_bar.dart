// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:countup/countup.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

// Project imports:
import 'package:words625/application/game_provider.dart';
import 'package:words625/di/injection.dart';
import 'package:words625/gen/assets.gen.dart';
import 'package:words625/routing/routing.gr.dart';
import 'package:words625/service/locator.dart';
import 'package:words625/views/theme.dart';
import 'package:words625/views/widgets/loader.dart';

class StatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      leading: const LanguageSelector(),
      title: const Row(
        children: [
          Padding(padding: EdgeInsets.all(16)),
          ScoreCard(),
          Padding(padding: EdgeInsets.all(12)),
          Streak(),
        ],
      ),
      actions: const [
        InfinityHeart(),
      ],
    );
  }
}

class Streak extends StatelessWidget {
  const Streak({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(VarnamalaTheme.radiusRound),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department_rounded,
              color: Color(0xFFFF9500), size: 20),
          const SizedBox(width: 4),
          StreamBuilder<int>(
            stream: context.read<GameProvider>().getUserStreakStream(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              if (snapshot.hasError) {
                return const Text('0');
              }
              return Countup(
                begin: 0,
                end: snapshot.data?.toDouble() ?? 0,
                duration: const Duration(milliseconds: 1000),
                separator: ',',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFFFF9500),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(VarnamalaTheme.radiusRound),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.stars_rounded, color: Color(0xFFFFD700), size: 20),
          const SizedBox(width: 4),
          StreamBuilder<int>(
            stream: context.read<GameProvider>().getUserScoreStream(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              if (snapshot.hasError) {
                return const Text('0');
              }
              return Countup(
                begin: 0,
                end: snapshot.data?.toDouble() ?? 0,
                duration: const Duration(milliseconds: 1000),
                separator: ',',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFFE5A800),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class InfinityHeart extends StatelessWidget {
  const InfinityHeart({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Infinite Hearts',
      triggerMode: TooltipTriggerMode.tap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(VarnamalaTheme.radiusRound),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_rounded, color: Color(0xFFE53935), size: 20),
            SizedBox(width: 2),
            Icon(Icons.all_inclusive_rounded,
                color: Color(0xFFE53935), size: 16),
          ],
        ),
      ),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferenceBuilder<String>(
      preference: getIt<AppPrefs>().currentLanguage,
      builder: (context, currentLanguage) {
        return GestureDetector(
          onTap: () {
            context.router.push(const LangChoiceRoute());
          },
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(VarnamalaTheme.radiusMedium),
              border: Border.all(
                width: 2,
                color: VarnamalaTheme.peacockTeal.withValues(alpha: 0.2),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(_getFlagPath(currentLanguage)),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getFlagPath(String language) {
    switch (language.toLowerCase()) {
      case 'kannada':
        return Assets.images.karnatakaFlag.path;
      case 'tamil':
        return Assets.images.tamilNaduFlag.path;
      case 'telugu':
        return Assets.images.telenganaFlag.path;
      case 'malayalam':
        return Assets.images.malayalamFlag.path;
      default:
        return Assets.images.karnatakaFlag.path;
    }
  }
}
