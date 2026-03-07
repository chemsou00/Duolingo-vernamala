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
    Achievement(
      id: 'scholar',
      type: AchievementType.scholar,
      title: 'Scholar',
      description: 'Learn new words',
      icon: Icons.auto_stories_rounded,
      color: Color(0xFF42A5F5),
      targets: [50, 100, 250, 500, 1000],
    ),
    Achievement(
        id: 'sage',
        type: AchievementType.sage,
        title: 'Sage',
        description: 'Earn XP in a single day',
        icon: Icons.psychology_rounded,
        color: Color(0xFF66BB6A),
        targets: [100, 250, 500, 1000, 2000]),
    Achievement(
      id: 'wildfire',
      type: AchievementType.wildfire,
      title: 'Wildfire',
      description: 'Reach a streak of days',
      icon: Icons.local_fire_department_rounded,
      color: Color(0xFFFF7043),
      targets: [3, 7, 14, 30, 75, 125, 200, 365],
    ),
    Achievement(
      id: 'champion',
      type: AchievementType.champion,
      title: 'Champion',
      description: 'Complete lessons',
      icon: Icons.workspace_premium_rounded,
      color: Color(0xFFAB47BC),
      targets: [10, 50, 100, 250, 500],
    ),
    Achievement(
      id: 'sharpshooter',
      type: AchievementType.sharpshooter,
      title: 'Sharpshooter',
      description: 'Complete lessons with no mistakes',
      icon: Icons.track_changes_rounded,
      color: Color(0xFFEF5350),
      targets: [1, 5, 20, 50, 100],
    ),
    Achievement(
      id: 'friendly',
      type: AchievementType.streak, // Using streak as placeholder for friends if no friends type
      title: 'Friendly',
      description: 'Follow friends',
      icon: Icons.people_rounded,
      color: Color(0xFF26C6DA),
      targets: [1, 5, 10, 20],
    ),
    Achievement(
      id: 'winner',
      type: AchievementType.xp, // Using xp as placeholder for league
      title: 'Winner',
      description: 'Finish #1 in your leaderboard',
      icon: Icons.emoji_events_rounded,
      color: Color(0xFFFFA726),
      targets: [1, 5, 10, 25],
    ),
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

      // TODO: Logic for gem rewards based on achievement tier
      // For now using simplified flat rate or calculating based on previous logic
      final gems = (data['gems'] as num? ?? 0).toInt() + 50; // Placeholder 50 gems
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
    // Check Champion (lessons)
    final champion = _achievementById['champion'];
    if (champion != null) {
      if (lessonsCompleted >= 10) await checkAndUnlock('champion'); // Simplified for now
    }
    
    // Check Sharpshooter (perfect lessons)
     final sharpshooter = _achievementById['sharpshooter'];
    if (sharpshooter != null) {
       if (perfectLessons >= 1) await checkAndUnlock('sharpshooter');
    }
  }

  Future<void> checkLeagueAchievement(String league) async {
    // Implement league checking when league achievements are fully defined
  }
}
