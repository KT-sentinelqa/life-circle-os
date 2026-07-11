import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/models/session.dart';

class SessionRepository {
  SessionRepository(this._isar);
  final Isar _isar;

  Future<void> saveSession(Session session) async {
    await _isar.writeTxn(() async {
      await _isar.sessions.put(session);
    });
  }

  Future<Session?> getActiveSession() async {
    final now = DateTime.now();
    return _isar.sessions
        .where()
        .filter()
        .refreshExpiresAtGreaterThan(now)
        .sortByLastActiveAtDesc()
        .findFirst();
  }

  Future<void> deleteSession(String sessionId) async {
    await _isar.writeTxn(() async {
      final session =
          await _isar.sessions.where().sessionIdEqualTo(sessionId).findFirst();
      if (session != null) {
        await _isar.sessions.delete(session.id);
      }
    });
  }

  Future<void> clearAllSessions() async {
    await _isar.writeTxn(() async {
      await _isar.sessions.clear();
    });
  }
}
