// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:words625/application/level_provider.dart';

class LessonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LessonAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width - 100,
        animation: true,
        lineHeight: 12.0,
        animationDuration: 200,
        percent: context.watch<LessonProvider>().percent,
        barRadius: const Radius.circular(6),
        backgroundColor: const Color(0xFFE5E7EB),
        progressColor: const Color(0xFF1F727E),
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Color(0xFF9CA3AF),
            size: 28,
          ),
          onPressed: () {
            context.read<LessonProvider>().reset();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
