// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

enum GemEvent {
  lessonComplete(5),
  perfectLesson(10),
  streakMilestone7(50),
  streakMilestone30(200),
  streakMilestone100(500),
  achievementUnlock(25),
  leaguePromotion(100);

  final int amount;
  const GemEvent(this.amount);
}

enum GemPurchase {
  streakFreeze(200),
  heartRefill(350),
  doubleXp(100);

  final int cost;
  const GemPurchase(this.cost);
}

@injectable
class GemsProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<int> getGemsStream() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return Stream.value(0);
    }

    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => _readInt(snapshot.data()?['gems'], 0));
  }

  Future<void> ensureGemsInitialized() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).set(
      {'gems': 0},
      SetOptions(merge: true),
    );
  }

  Future<void> earnGems(GemEvent event) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      'gems': FieldValue.increment(event.amount),
    });
    notifyListeners();
  }

  Future<bool> spendGems(GemPurchase purchase) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return false;

    final docRef = _firestore.collection('users').doc(userId);

    final success = await _firestore.runTransaction<bool>((transaction) async {
      final doc = await transaction.get(docRef);
      if (!doc.exists) return false;

      final data = doc.data() ?? <String, dynamic>{};
      final gems = _readInt(data['gems'], 0);
      if (gems < purchase.cost) return false;

      final updates = <String, dynamic>{'gems': gems - purchase.cost};

      switch (purchase) {
        case GemPurchase.streakFreeze:
          final streakFreezes = _readInt(data['streakFreezes'], 0);
          if (streakFreezes >= 2) return false;
          updates['streakFreezes'] = streakFreezes + 1;
          break;
        case GemPurchase.heartRefill:
          updates['hearts'] = 5;
          updates['heartsRefillAt'] = null;
          break;
        case GemPurchase.doubleXp:
          updates['doubleXpUntil'] =
              Timestamp.fromDate(DateTime.now().add(const Duration(minutes: 30)));
          break;
      }

      transaction.update(docRef, updates);
      return true;
    });

    if (success) notifyListeners();
    return success;
  }

  int _readInt(dynamic value, int fallback) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return fallback;
  }
}
