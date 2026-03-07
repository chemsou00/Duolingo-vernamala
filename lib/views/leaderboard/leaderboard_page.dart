// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:words625/core/extensions.dart';
import 'package:words625/views/theme.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('score', descending: true)
          .limit(30)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: VarnamalaTheme.peacockTeal,
              strokeWidth: 3,
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.leaderboard_rounded,
                    size: 64,
                    color: VarnamalaTheme.textHint.withValues(alpha: 0.3)),
                const SizedBox(height: 16),
                Text(
                  'No leaderboard data yet',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: VarnamalaTheme.textHint,
                      ),
                ),
              ],
            ),
          );
        }

        final users = snapshot.data!.docs;

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // League header card
            SliverToBoxAdapter(
              child: _LeagueHeader(),
            ),
            // Leaderboard list
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final userData =
                        users[index].data() as Map<String, dynamic>;
                    final xp = userData['score'] ?? 0;
                    final name = userData['name'] ?? 'Anonymous';
                    final image = userData['profileImage'] ??
                        'assets/images/default_image.png';
                    final languages =
                        userData['languages'] as List<dynamic>? ?? [];

                    return _LeaderboardTile(
                      rank: index + 1,
                      name: name,
                      image: image,
                      xp: xp,
                      languages: languages.cast<String>(),
                    );
                  },
                  childCount: users.length,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        );
      },
    );
  }
}

class _LeagueHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7B2FBE), Color(0xFF9B59B6)],
        ),
        borderRadius: BorderRadius.circular(VarnamalaTheme.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: VarnamalaTheme.leagueAmethyst.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.shield_rounded, color: Colors.white, size: 40),
          const SizedBox(height: 8),
          const Text(
            'Amethyst League',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Top 10 advance to the next league',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  final int rank;
  final String name;
  final String image;
  final int xp;
  final List<String> languages;

  const _LeaderboardTile({
    required this.rank,
    required this.name,
    required this.image,
    required this.xp,
    required this.languages,
  });

  @override
  Widget build(BuildContext context) {
    final isTopThree = rank <= 3;
    final rankColors = {
      1: const Color(0xFFFFD700),
      2: const Color(0xFFC0C0C0),
      3: const Color(0xFFCD7F32),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isTopThree
            ? rankColors[rank]!.withValues(alpha: 0.06)
            : Colors.white,
        borderRadius: BorderRadius.circular(VarnamalaTheme.radiusMedium),
        border: Border.all(
          color: isTopThree
              ? rankColors[rank]!.withValues(alpha: 0.2)
              : const Color(0xFFEEF2F1),
        ),
      ),
      child: Row(
        children: [
          // Rank
          SizedBox(
            width: 32,
            child: isTopThree
                ? Icon(
                    Icons.emoji_events_rounded,
                    color: rankColors[rank],
                    size: 24,
                  )
                : Text(
                    '$rank',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: VarnamalaTheme.textHint,
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          // Avatar
          CircleAvatar(
            backgroundImage: NetworkImage(image),
            radius: 20,
            backgroundColor: VarnamalaTheme.peacockTeal.withValues(alpha: 0.1),
          ),
          const SizedBox(width: 12),
          // Name & languages
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (languages.isNotEmpty)
                  Text(
                    languages.join(', ').toTitleCase,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: VarnamalaTheme.peacockTeal,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
              ],
            ),
          ),
          // XP
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: VarnamalaTheme.peacockTeal.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(VarnamalaTheme.radiusRound),
            ),
            child: Text(
              '$xp XP',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: VarnamalaTheme.peacockTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
