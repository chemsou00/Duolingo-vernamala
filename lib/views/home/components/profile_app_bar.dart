// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:words625/views/theme.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Profile',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.share_rounded,
              color: VarnamalaTheme.peacockTeal, size: 22),
          tooltip: 'Share',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings_rounded,
              color: VarnamalaTheme.peacockTeal, size: 22),
          tooltip: 'Settings',
          onPressed: () {},
        ),
      ],
    );
  }
}
