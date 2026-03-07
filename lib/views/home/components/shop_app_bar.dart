// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:words625/views/widgets/gems_display.dart';

class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Shop',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: GemsDisplay(),
        ),
      ],
    );
  }
}
