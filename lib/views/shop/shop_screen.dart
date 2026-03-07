// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:words625/routing/routing.gr.dart';
import 'package:words625/views/auth/components/logout_button.dart';
import 'package:words625/views/theme.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        // Streak section
        SliverToBoxAdapter(
          child: _SectionTitle(title: 'Streak', icon: Icons.local_fire_department_rounded, iconColor: const Color(0xFFFF9500)),
        ),
        SliverToBoxAdapter(
          child: ShopItem(
            icon: Icons.ac_unit_rounded,
            iconColor: const Color(0xFF42A5F5),
            label: 'Streak Freeze',
            description:
                'Protect your streak if you miss a day of practice. Equip up to 2 at once.',
            current: 2,
            total: 2,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Material(
              color: VarnamalaTheme.peacockTeal,
              borderRadius: BorderRadius.circular(VarnamalaTheme.radiusMedium),
              child: InkWell(
                borderRadius: BorderRadius.circular(VarnamalaTheme.radiusMedium),
                onTap: () {
                  context.router.push(const MatchWordsRoute());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bolt_rounded, color: Colors.white, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Try Match Madness',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // Power-ups section
        SliverToBoxAdapter(
          child: _SectionTitle(title: 'Power-Ups', icon: Icons.bolt_rounded, iconColor: VarnamalaTheme.warning),
        ),
        SliverToBoxAdapter(
          child: ShopItem(
            icon: Icons.calendar_month_rounded,
            iconColor: const Color(0xFF66BB6A),
            label: 'Double or Nothing',
            description:
                'Attempt to double your five lingot wager by maintaining a seven-day streak.',
            price: 450,
          ),
        ),
        // Outfits section
        SliverToBoxAdapter(
          child: _SectionTitle(title: 'Outfits', icon: Icons.checkroom_rounded, iconColor: VarnamalaTheme.leagueAmethyst),
        ),
        SliverToBoxAdapter(
          child: ShopItem(
            icon: Icons.workspace_premium_rounded,
            iconColor: const Color(0xFF5C6BC0),
            label: 'Formal Attire',
            description:
                "Learn in style. Mala has always been sharp, now she'll look sharp too.",
            price: 1000,
          ),
        ),
        SliverToBoxAdapter(
          child: ShopItem(
            icon: Icons.diamond_rounded,
            iconColor: const Color(0xFFAB47BC),
            label: 'Luxury Tracksuit',
            description:
                'Learn in luxury. Mala will love the feel of 24-carat gold silk on her feathers.',
            price: 2000,
          ),
        ),
        SliverToBoxAdapter(
          child: ShopItem(
            icon: Icons.flash_on_rounded,
            iconColor: const Color(0xFFEF5350),
            label: 'Super Mala',
            description:
                'Transform Mala from a cute peacock into a fearless feathered Guru.',
            price: 3000,
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: LogoutButton(),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const _SectionTitle({
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class ShopItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String description;
  final int? price;
  final int? current;
  final int? total;

  const ShopItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.description,
    this.price,
    this.current,
    this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VarnamalaTheme.radiusLarge),
        border: Border.all(color: const Color(0xFFEEF2F1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(VarnamalaTheme.radiusMedium),
            ),
            child: Icon(icon, color: iconColor, size: 28),
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: VarnamalaTheme.textSecondary,
                        height: 1.3,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                price != null
                    ? _PriceTag(price: price!)
                    : _EquippedTag(current: current!, total: total!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final int price;
  const _PriceTag({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(VarnamalaTheme.radiusRound),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.diamond_rounded, color: Color(0xFFE53935), size: 14),
          const SizedBox(width: 4),
          Text(
            '$price',
            style: const TextStyle(
              color: Color(0xFFE53935),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _EquippedTag extends StatelessWidget {
  final int current;
  final int total;
  const _EquippedTag({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: VarnamalaTheme.peacockTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(VarnamalaTheme.radiusRound),
      ),
      child: Text(
        '$current / $total EQUIPPED',
        style: const TextStyle(
          color: VarnamalaTheme.peacockTeal,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
