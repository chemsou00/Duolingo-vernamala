// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

enum XPEvent {
  lessonComplete(base: 10),
  perfectLesson(base: 15),
  dailyGoalComplete(base: 20),
  streakBonus(base: 5),
  challengeWin(base: 25);

  final int base;
  const XPEvent({required this.base});
}

enum StreakCheckResult {
  none,
  maintained,
  freezeConsumed,
  broken,
}

@injectable
class GameProvider extends ChangeNotifier {
  static const String bronzeLeague = 'bronze';
  static const int defaultDailyXpGoal = 50;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreakCheckResult _lastStreakCheckResult = StreakCheckResult.none;

  StreakCheckResult get lastStreakCheckResult => _lastStreakCheckResult;

  Stream<int> getUserStreakStream() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return Stream.value(0);
    }

    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => _readInt(snapshot.data(), 'streak', 0));
  }

  Stream<int> getUserScoreStream() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return Stream.value(0);
    }

    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => _readInt(snapshot.data(), 'score', 0));
  }

  Stream<Map<String, dynamic>> getUserGameStateStream() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return Stream.value(<String, dynamic>{});
    }

    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => snapshot.data() ?? <String, dynamic>{});
  }

  Future<Map<String, dynamic>> getUserGameStateOnce() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return <String, dynamic>{};

    final snapshot = await _firestore.collection('users').doc(userId).get();
    return snapshot.data() ?? <String, dynamic>{};
  }

  Future<void> ensureUserGameFields() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore.collection('users').doc(userId);
    final snapshot = await docRef.get();
    if (!snapshot.exists) return;

    final data = snapshot.data() ?? <String, dynamic>{};
    final now = DateTime.now();
    final score = _readInt(data, 'score', 0);
    final hasLeagueXp = data['leagueXp'] is num;
    final leagueXp = _readInt(data, 'leagueXp', 0);
    final leagueXpMigrated = data['leagueXpMigratedFromScore'] as bool? ?? false;
    final initialLeagueXp = !leagueXpMigrated && score > 0 && (!hasLeagueXp || leagueXp == 0)
        ? score
        : leagueXp;

    final defaults = <String, dynamic>{
      'gems': _readInt(data, 'gems', 0),
      'hearts': _readInt(data, 'hearts', 5),
      'heartsRefillAt': data['heartsRefillAt'],
      'streakFreezes': _readInt(data, 'streakFreezes', 0),
      'streakFreezeActive': data['streakFreezeActive'] as bool? ?? false,
      'league': data['league'] as String? ?? bronzeLeague,
      'leagueXp': initialLeagueXp,
      'leagueXpMigratedFromScore': true,
      'leagueJoinedAt': data['leagueJoinedAt'] ?? FieldValue.serverTimestamp(),
      'achievements':
          (data['achievements'] as List<dynamic>?)?.whereType<String>().toList() ??
              <String>[],
      'dailyXpGoal': _readInt(data, 'dailyXpGoal', defaultDailyXpGoal),
      'dailyXpEarned': _readInt(data, 'dailyXpEarned', 0),
      'lastDailyReset':
          data['lastDailyReset'] ?? DateTime(now.year, now.month, now.day).toIso8601String(),
      'lessonsCompleted': _readInt(data, 'lessonsCompleted', 0),
      'perfectLessons': _readInt(data, 'perfectLessons', 0),
      'streakWasBroken': data['streakWasBroken'] as bool? ?? false,
      'doubleXpUntil': data['doubleXpUntil'],
    };

    await docRef.set(defaults, SetOptions(merge: true));
  }

  Future<int> awardXP(
    XPEvent event, {
    double multiplier = 1.0,
    bool notify = true,
  }) async {
    final xp = (event.base * multiplier).round();
    if (xp <= 0) return 0;

    await incrementScore(xp, notify: false);

    if (notify) notifyListeners();
    return xp;
  }

  Future<void> incrementScore(int xp, {bool notify = true}) async {
    if (xp <= 0) return;

    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final userDocRef = _firestore.collection('users').doc(userId);

    try {
      await _firestore.runTransaction((transaction) async {
        final doc = await transaction.get(userDocRef);
        if (!doc.exists) return;

        final data = doc.data() ?? <String, dynamic>{};
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        final score = _readInt(data, 'score', 0);
        final streak = _readInt(data, 'streak', 0);
        final leagueXp = _readInt(data, 'leagueXp', 0);

        final streakResolution = _resolveStreakOnPractice(
          oldStreak: streak,
          oldDate: _parseDate(data['lastStreakDate']),
          today: today,
          streakFreezeActive: data['streakFreezeActive'] as bool? ?? false,
          streakFreezes: _readInt(data, 'streakFreezes', 0),
        );

        var newScore = score + xp;
        var newGems = _readInt(data, 'gems', 0);

        final achievements =
            (data['achievements'] as List<dynamic>? ?? const <dynamic>[])
                .whereType<String>()
                .toSet();

        newGems += _unlockXpAchievements(achievements, newScore);
        newGems += _unlockStreakAchievements(
          achievements,
          streakResolution.newStreak,
        );

        final dailyResetDate = _parseDate(data['lastDailyReset']);
        var dailyXpEarned = _readInt(data, 'dailyXpEarned', 0);
        if (dailyResetDate == null || !_isSameDay(dailyResetDate, today)) {
          dailyXpEarned = 0;
        }

        final dailyGoal = _readInt(data, 'dailyXpGoal', defaultDailyXpGoal);
        final previousDailyXp = dailyXpEarned;
        dailyXpEarned += xp;

        if (previousDailyXp < dailyGoal && dailyXpEarned >= dailyGoal) {
          newScore += XPEvent.dailyGoalComplete.base;
        }

        final updates = <String, dynamic>{
          'score': newScore,
          'streak': streakResolution.newStreak,
          'lastStreakDate': today.toIso8601String(),
          'streakFreezes': streakResolution.remainingFreezes,
          'streakFreezeActive': streakResolution.freezeActive,
          'streakWasBroken': streakResolution.broken,
          'leagueXp': leagueXp + xp,
          'dailyXpEarned': dailyXpEarned,
          'dailyXpGoal': dailyGoal,
          'lastDailyReset': today.toIso8601String(),
          'gems': newGems,
          'achievements': achievements.toList(growable: false),
        };

        if (streakResolution.broken) {
          updates['lastStreakBreakDate'] = FieldValue.serverTimestamp();
        }

        transaction.update(userDocRef, updates);
      });

      if (notify) notifyListeners();
    } catch (e) {
      debugPrint('Error updating score and streak: $e');
    }
  }

  Future<void> recordLessonCompletion({
    required bool wasPerfect,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore.collection('users').doc(userId);
    await _firestore.runTransaction((transaction) async {
      final doc = await transaction.get(docRef);
      if (!doc.exists) return;

      final data = doc.data() ?? <String, dynamic>{};
      final lessonsCompleted = _readInt(data, 'lessonsCompleted', 0) + 1;
      final perfectLessons = _readInt(data, 'perfectLessons', 0) +
          (wasPerfect ? 1 : 0);
      transaction.update(docRef, {
        'lessonsCompleted': lessonsCompleted,
        'perfectLessons': perfectLessons,
      });
    });
  }

  Future<StreakCheckResult> checkStreakOnAppOpen() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      _lastStreakCheckResult = StreakCheckResult.none;
      return _lastStreakCheckResult;
    }

    final docRef = _firestore.collection('users').doc(userId);

    try {
      final result = await _firestore.runTransaction<StreakCheckResult>(
        (transaction) async {
          final doc = await transaction.get(docRef);
          if (!doc.exists) return StreakCheckResult.none;

          final data = doc.data() ?? <String, dynamic>{};
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final lastDate = _parseDate(data['lastStreakDate']);

          if (lastDate == null) {
            return StreakCheckResult.none;
          }

          final last = DateTime(lastDate.year, lastDate.month, lastDate.day);
          final gap = today.difference(last).inDays;

          if (gap <= 1) {
            transaction.update(docRef, {'streakWasBroken': false});
            return StreakCheckResult.maintained;
          }

          final streakFreezes = _readInt(data, 'streakFreezes', 0);
          final freezeActive = data['streakFreezeActive'] as bool? ?? false;

          if (gap == 2 && (freezeActive || streakFreezes > 0)) {
            transaction.update(docRef, {
              'streakFreezes': freezeActive ? streakFreezes : streakFreezes - 1,
              'streakFreezeActive': false,
              'lastStreakDate': today.toIso8601String(),
              'streakWasBroken': false,
            });
            return StreakCheckResult.freezeConsumed;
          }

          transaction.update(docRef, {
            'streak': 0,
            'streakWasBroken': true,
            'lastStreakBreakDate': FieldValue.serverTimestamp(),
          });
          return StreakCheckResult.broken;
        },
      );

      _lastStreakCheckResult = result;
      notifyListeners();
      return result;
    } catch (e) {
      debugPrint('Error checking streak on app open: $e');
      _lastStreakCheckResult = StreakCheckResult.none;
      return _lastStreakCheckResult;
    }
  }

  int _unlockXpAchievements(Set<String> achievements, int score) {
    var gemsReward = 0;
    if (score >= 1000 && achievements.add('xp_1000')) gemsReward += 25;
    if (score >= 10000 && achievements.add('xp_10000')) gemsReward += 100;
    if (score >= 50000 && achievements.add('xp_50000')) gemsReward += 250;
    return gemsReward;
  }

  int _unlockStreakAchievements(Set<String> achievements, int streak) {
    var gemsReward = 0;
    if (streak >= 3 && achievements.add('streak_3')) gemsReward += 15;
    if (streak >= 7 && achievements.add('streak_7')) gemsReward += 50;
    if (streak >= 30 && achievements.add('streak_30')) gemsReward += 200;
    if (streak >= 100 && achievements.add('streak_100')) gemsReward += 500;
    if (streak >= 365 && achievements.add('streak_365')) gemsReward += 1000;
    return gemsReward;
  }

  bool _isSameDay(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  int _readInt(Map<String, dynamic>? data, String key, int fallback) {
    final value = data?[key];
    if (value is int) return value;
    if (value is num) return value.toInt();
    return fallback;
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  _StreakResolution _resolveStreakOnPractice({
    required int oldStreak,
    required DateTime? oldDate,
    required DateTime today,
    required bool streakFreezeActive,
    required int streakFreezes,
  }) {
    if (oldDate == null) {
      return _StreakResolution(
        newStreak: oldStreak == 0 ? 1 : oldStreak,
        remainingFreezes: streakFreezes,
        freezeActive: streakFreezeActive,
        broken: false,
      );
    }

    final last = DateTime(oldDate.year, oldDate.month, oldDate.day);
    final gap = today.difference(last).inDays;

    if (gap <= 0) {
      return _StreakResolution(
        newStreak: oldStreak,
        remainingFreezes: streakFreezes,
        freezeActive: streakFreezeActive,
        broken: false,
      );
    }

    if (gap == 1) {
      return _StreakResolution(
        newStreak: oldStreak + 1,
        remainingFreezes: streakFreezes,
        freezeActive: streakFreezeActive,
        broken: false,
      );
    }

    if (gap == 2 && (streakFreezeActive || streakFreezes > 0)) {
      return _StreakResolution(
        newStreak: oldStreak + 1,
        remainingFreezes: streakFreezeActive ? streakFreezes : streakFreezes - 1,
        freezeActive: false,
        broken: false,
      );
    }

    return _StreakResolution(
      newStreak: 1,
      remainingFreezes: streakFreezes,
      freezeActive: streakFreezeActive,
      broken: true,
    );
  }
}

class _StreakResolution {
  final int newStreak;
  final int remainingFreezes;
  final bool freezeActive;
  final bool broken;

  _StreakResolution({
    required this.newStreak,
    required this.remainingFreezes,
    required this.freezeActive,
    required this.broken,
  });
}
