// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

// Project imports:
import 'package:words625/di/injection.dart';
import 'package:words625/domain/auth/firebase_user.dart';
import 'package:words625/service/locator.dart';
import 'package:words625/views/theme.dart';

class AccountAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(0);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class AccountWidget extends StatelessWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferenceBuilder<SerializableFirebaseUser?>(
      preference: getIt<AppPrefs>().authUser,
      builder: (BuildContext context, SerializableFirebaseUser? user) {
        final displayName = user?.displayName ?? 'Guest';
        final email = user?.email ?? 'No email';
        final profileImage =
            user?.photoUrl ?? 'https://example.com/default_avatar.png';

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(VarnamalaTheme.radiusLarge),
            border: Border.all(color: const Color(0xFFEEF2F1)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor:
                    VarnamalaTheme.peacockTeal.withValues(alpha: 0.1),
                backgroundImage: NetworkImage(profileImage),
                onBackgroundImageError: (_, __) {},
                child: user?.photoUrl == null
                    ? const Icon(Icons.person_rounded,
                        size: 28, color: VarnamalaTheme.peacockTeal)
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      email,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: VarnamalaTheme.textHint,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
