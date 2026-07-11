import 'dart:math';
import 'package:lifecircle_mobile/src/core/utils/trusted_clock.dart';
import 'package:lifecircle_mobile/src/features/family_invite/domain/models/family_invite.dart';

class InviteService {
  InviteService(this._clock);
  final TrustedClock _clock;

  /// Generates a secure invite code that does NOT leak the household ID.
  /// (SEC-026: Privacy by Default for Invitations)
  Future<FamilyInvite> generateInvite(
    String householdId,
    String proposedRole,
  ) async {
    final now = _clock.now();
    final inviteCode = _generateRandomCode(8);

    final invite = FamilyInvite()
      ..inviteCode = inviteCode
      ..householdId = householdId
      ..proposedRole = proposedRole
      ..createdAt = now
      ..expiresAt = now.add(const Duration(hours: 48))
      ..isAccepted = false;

    // In real implementation, this hits an API endpoint to register the invite on the Cloud,
    // and stores a local record in Isar for audit purposes.

    return invite;
  }

  /// Accepts an invite. Requires the device to be registered and authenticated.
  Future<bool> acceptInvite(String inviteCode) async {
    // 1. Hit API endpoint /family/invite/accept
    // 2. Cloud verifies code hasn't expired or been used
    // 3. Cloud adds this UserID to the Household
    // 4. Cloud begins syncing Household data to this device
    return true; // dummy success
  }

  String _generateRandomCode(int length) {
    const chars =
        'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // No visually ambiguous chars (I/1/O/0)
    final rnd = Random.secure();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }
}
