// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:words625/domain/achievement.dart';

@injectable
class AchievementsProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const List<Achievement> allAchievements = [
    Achievement(id: 'first_lesson', title: 'First Steps', description: 'Complete your first lesson', gems: 10),
    Achievement(id: 'lessons_10', title: 'Getting Started', description: 'Complete 10 lessons', gems: 25),
    Achievement(id: 'lessons_50', title: 'Dedicated Learner', description: 'Complete 50 lessons', gems: 50),
    Achievement(id: 'lessons_100', title: 'Century', description: 'Complete 100 lessons', gems: 100),
    Achievement(id: 'streak_3', title: 'On a Roll', description: '3-day streak', gems: 15),
    Achievement(id: 'streak_7', title: 'Week Warrior', description: '7-day streak', gems: 50),
    Achievement(id: 'streak_30', title: 'Monthly Master', description: '30-day streak', gems: 200),
    Achievement(id: 'streak_100', title: 'Unstoppable', description: '100-day streak', gems: 500),
    Achievement(id: 'streak_365', title: 'Year of Learning', description: '365-day streak', gems: 1000),
    Achievement(id: 'xp_1000', title: 'XP Explorer', description: 'Earn 1,000 XP', gems: 25),
    Achievement(id: 'xp_10000', title: 'XP Champion', description: 'Earn 10,000 XP', gems: 100),
    Achievement(id: 'xp_50000', title: 'XP Legend', description: 'Earn 50,000 XP', gems: 250),
    Achievement(id: 'perfect_1', title: 'Flawless', description: 'Complete a lesson with no mistakes', gems: 10),
    Achievement(id: 'perfect_10', title: 'Perfectionist', description: '10 perfect lessons', gems: 50),
    Achievement(id: 'league_silver', title: 'Rising Star', description: 'Reach Silver league', gems: 25),
    Achievement(id: 'league_gold', title: 'Golden Touch', description: 'Reach Gold league', gems: 50),
    Achievement(id: 'league_diamond', title: 'Diamond Elite', description: 'Reach Diamond league', gems: 200),
    Achievement(id: 'learn_2_langs', title: 'Bilingual', description: 'Study 2 languages', gems: 50),
    Achievement(id: 'learn_4_langs', title: 'Polyglot', description: 'Study all 4 languages', gems: 200),
  ];

  static final Map<String, Achievement> _achievementById = {
    for (final achievement in allAchievements) achievement.id: achievement,
  };

  Stream<List<String>> getUnlockedAchievements() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value(const <String>[]);

    return _firestore.collection('users').doc(userId).snapshots().map((doc) {
      final data = doc.data() ?? <String, dynamic>{};
      return (data['achievements'] as List<dynamic>? ?? const <dynamic>[])
          .whereType<String>()
          .toList(growable: false);
    });
  }

  Future<bool> checkAndUnlock(String achievementId) async {
    final achievement = _achievementById[achievementId];
    if (achievement == null) return false;

    final userId = _auth.currentUser?.uid;
    if (userId == null) return false;

    final docRef = _firestore.collection('users').doc(userId);

    final unlocked = await _firestore.runTransaction<bool>((transaction) async {
      final doc = await transaction.get(docRef);
      if (!doc.exists) return false;

      final data = doc.data() ?? <String, dynamic>{};
      final unlocked = (data['achievements'] as List<dynamic>? ?? const <dynamic>[])
          .whereType<String>()
          .toSet();

      if (!unlocked.add(achievementId)) {
        return false;
      }

      final gems = (data['gems'] as num? ?? 0).toInt() + achievement.gems;
      transaction.update(docRef, {
        'achievements': unlocked.toList(growable: false),
        'gems': gems,
      });

      return true;
    });

    if (unlocked) notifyListeners();
    return unlocked;
  }

  Future<void> checkLessonMilestones({
    required int lessonsCompleted,
    required int perfectLessons,
  }) async {
    if (lessonsCompleted >= 1) await checkAndUnlock('first_lesson');
    if (lessonsCompleted >= 10) await checkAndUnlock('lessons_10');
    if (lessonsCompleted >= 50) await checkAndUnlock('lessons_50');
    if (lessonsCompleted >= 100) await checkAndUnlock('lessons_100');

    if (perfectLessons >= 1) await checkAndUnlock('perfect_1');
    if (perfectLessons >= 10) await checkAndUnlock('perfect_10');
  }

  Future<void> checkLeagueAchievement(String league) async {
    if (league == 'silver') await checkAndUnlock('league_silver');
    if (league == 'gold') await checkAndUnlock('league_gold');
    if (league == 'diamond') await checkAndUnlock('league_diamond');
  }
}
