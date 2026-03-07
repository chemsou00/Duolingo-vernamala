// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/annotations.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:words625/application/game_provider.dart';
import 'package:words625/application/gems_provider.dart';
import 'package:words625/application/hearts_provider.dart';
import 'package:words625/application/language_provider.dart';
import 'package:words625/views/characters/character_drawing.dart';
import 'package:words625/views/characters/characters_app_bar.dart';
import 'package:words625/views/courses/course_tree.dart';
import 'package:words625/views/home/components/components.dart';
import 'package:words625/views/leaderboard/leaderboard_page.dart';
import 'package:words625/views/profile/profile_screen.dart';
import 'package:words625/views/shop/shop_screen.dart';
import 'package:words625/views/theme.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final screens = [
    const CourseTree(),
    const CharacterPracticeScreen(),
    const ProfilePage(),
    const LeaderboardPage(),
    const ShopPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initSession();
    });
  }

  initSession() async {
    context.read<LanguageProvider>().initLanguage();
    final gameProvider = context.read<GameProvider>();
    final heartsProvider = context.read<HeartsProvider>();
    final gemsProvider = context.read<GemsProvider>();

    await gameProvider.ensureUserGameFields();
    await gemsProvider.ensureGemsInitialized();
    await heartsProvider.ensureHeartsInitialized();
    await heartsProvider.refillHeart();
    final streakResult = await gameProvider.checkStreakOnAppOpen();

    if (!mounted) return;
    if (streakResult == StreakCheckResult.broken) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your streak was broken. Start again today.'),
          backgroundColor: VarnamalaTheme.error,
        ),
      );
    } else if (streakResult == StreakCheckResult.freezeConsumed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Streak Freeze protected your streak.'),
        ),
      );
    }
  }

  final List<PreferredSizeWidget> appBars = [
    const StatAppBar(),
    const CharactersAppBar(),
    const ProfileAppBar(),
    const LeaderboardAppBar(),
    const ShopAppBar(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex == 0
          ? VarnamalaTheme.scaffoldBackground
          : Colors.white,
      appBar: appBars[currentIndex],
      bottomNavigationBar: BottomNavigator(
        currentIndex: currentIndex,
        onPress: onBottomNavigatorTapped,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: screens[currentIndex],
      ),
    );
  }

  void onBottomNavigatorTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

class CharacterLearningPage extends StatelessWidget {
  const CharacterLearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CharacterPracticeScreen();
  }
}
