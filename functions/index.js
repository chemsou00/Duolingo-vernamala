const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

const LEAGUES = [
  'bronze',
  'silver',
  'gold',
  'amethyst',
  'pearl',
  'ruby',
  'emerald',
  'diamond',
];

function clampLeagueIndex(index) {
  return Math.max(0, Math.min(LEAGUES.length - 1, index));
}

async function backfillUsersToBronzeDefaults() {
  const db = admin.firestore();
  const snapshot = await db.collection('users').get();

  let batch = db.batch();
  let writes = 0;

  for (const doc of snapshot.docs) {
    const data = doc.data() || {};
    const updates = {};
    const score = typeof data.score === 'number' ? data.score : 0;
    const hasNumericLeagueXp = typeof data.leagueXp === 'number';
    const isMigrated = data.leagueXpMigratedFromScore === true;

    if (!data.league || !LEAGUES.includes(data.league)) {
      updates.league = 'bronze';
      updates.leagueJoinedAt = admin.firestore.FieldValue.serverTimestamp();
    }

    if (!isMigrated) {
      if (!hasNumericLeagueXp) {
        updates.leagueXp = score;
      } else if (data.leagueXp === 0 && score > 0) {
        // Legacy users who were defaulted to 0 get a one-time restore from total score.
        updates.leagueXp = score;
      }
      updates.leagueXpMigratedFromScore = true;
    } else if (!hasNumericLeagueXp) {
      // Keep schema consistent even after migration.
      updates.leagueXp = 0;
    }

    if (Object.keys(updates).length > 0) {
      batch.set(doc.ref, updates, { merge: true });
      writes += 1;
    }

    if (writes === 400) {
      await batch.commit();
      batch = db.batch();
      writes = 0;
    }
  }

  if (writes > 0) {
    await batch.commit();
  }
}

exports.backfillLeagueDefaults = functions.pubsub
  .schedule('every 24 hours')
  .timeZone('Asia/Kolkata')
  .onRun(async () => {
    await backfillUsersToBronzeDefaults();
    return null;
  });

exports.weeklyLeagueUpdate = functions.pubsub
  .schedule('every sunday 23:59')
  .timeZone('Asia/Kolkata')
  .onRun(async () => {
    const db = admin.firestore();

    await backfillUsersToBronzeDefaults();

    for (let i = 0; i < LEAGUES.length; i += 1) {
      const league = LEAGUES[i];
      const snapshot = await db
        .collection('users')
        .where('league', '==', league)
        .orderBy('leagueXp', 'desc')
        .get();

      const users = snapshot.docs;
      const topTen = users.slice(0, 10);
      const bottomFive = users.slice(-5);

      const batch = db.batch();

      for (const doc of users) {
        batch.update(doc.ref, { leagueXp: 0 });
      }

      for (const doc of topTen) {
        const nextLeague = LEAGUES[clampLeagueIndex(i + 1)];
        batch.update(doc.ref, {
          league: nextLeague,
          leagueJoinedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      if (league !== LEAGUES[0]) {
        for (const doc of bottomFive) {
          const previousLeague = LEAGUES[clampLeagueIndex(i - 1)];
          batch.update(doc.ref, {
            league: previousLeague,
            leagueJoinedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }
      }

      await batch.commit();
    }

    return null;
  });
