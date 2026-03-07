// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:words625/application/level_provider.dart';
import 'package:words625/views/theme.dart';

class LessonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LessonAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: VarnamalaTheme.textHint,
            size: 26,
          ),
          onPressed: () {
            context.read<LessonProvider>().reset();
            Navigator.pop(context);
          },
        ),
      ),
      title: Consumer<LessonProvider>(
        builder: (context, lessonProvider, _) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(VarnamalaTheme.radiusRound),
            child: LinearProgressIndicator(
              value: lessonProvider.percent,
              minHeight: 10,
              backgroundColor: const Color(0xFFEEF2F1),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  VarnamalaTheme.peacockTurquoise),
            ),
          );
        },
      ),
      centerTitle: true,
    );
  }
}
