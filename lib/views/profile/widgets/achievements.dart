// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:words625/views/theme.dart';

class Achievements extends StatelessWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(context, 'Achievements', Icons.military_tech_rounded),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(VarnamalaTheme.radiusLarge),
              border: Border.all(color: const Color(0xFFEEF2F1)),
            ),
            child: Column(
              children: [
                _AchievementTile(
                  icon: Icons.auto_stories_rounded,
                  iconColor: const Color(0xFF42A5F5),
                  label: 'Scholar',
                  description: 'Learn 1,000 new words',
                  current: 34,
                  target: 50,
                  level: 9,
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _AchievementTile(
                  icon: Icons.psychology_rounded,
                  iconColor: const Color(0xFF66BB6A),
                  label: 'Sage',
                  description: 'Learn 1,000 new words in a single course',
                  current: 50,
                  target: 100,
                  level: 1,
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _AchievementTile(
                  icon: Icons.workspace_premium_rounded,
                  iconColor: const Color(0xFFAB47BC),
                  label: 'Champion',
                  description: 'Complete 200 lessons',
                  current: 150,
                  target: 200,
                  level: 2,
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: const BorderRadius.only(
                      bottomLeft:
                          Radius.circular(VarnamalaTheme.radiusLarge),
                      bottomRight:
                          Radius.circular(VarnamalaTheme.radiusLarge),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Text(
                            'View 7 more',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: VarnamalaTheme.peacockTeal,
                                ),
                          ),
                          const Spacer(),
                          const Icon(Icons.chevron_right_rounded,
                              color: VarnamalaTheme.peacockTeal, size: 22),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: VarnamalaTheme.peacockTeal, size: 22),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String description;
  final int current;
  final int target;
  final int level;

  const _AchievementTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.description,
    required this.current,
    required this.target,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius:
                  BorderRadius.circular(VarnamalaTheme.radiusMedium),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 24),
                Text(
                  'Lv.$level',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: VarnamalaTheme.textSecondary,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            VarnamalaTheme.radiusRound),
                        child: LinearProgressIndicator(
                          value: current / target,
                          minHeight: 8,
                          backgroundColor: const Color(0xFFEEF2F1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              VarnamalaTheme.success),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$current/$target',
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: VarnamalaTheme.textHint,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
