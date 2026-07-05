import '../../responsibilities/domain/models/family_responsibility.dart';
import '../../responsibilities/domain/models/responsibility_status.dart';
import '../../responsibilities/domain/models/responsibility_category.dart';

class PeaceIndexService {
  /// Applies SEC-016 Contextual Aggregation:
  /// Filters the responsibilities based on the current user's authorized view
  /// before calculating the score.
  int calculateContextualIndex(String currentUserId, List<FamilyResponsibility> allResponsibilities) {
    // SEC-016 Boundary: Only aggregate what this user is allowed to see.
    // In a full implementation, this integrates with the FamilyConsentModel.
    // For now, we assume the list passed in is already filtered or we filter here.
    final authorizedResponsibilities = allResponsibilities.where((r) {
      return r.primaryOwnerId == currentUserId || r.backupOwnerId == currentUserId; 
      // + Add logic for caregivers with explicit consent.
    }).toList();

    int score = 100;
    
    for (var resp in authorizedResponsibilities) {
      if (resp.status == ResponsibilityStatus.escalated) {
        if (resp.category == ResponsibilityCategory.health) {
          score -= 20;
        } else if (resp.category == ResponsibilityCategory.finance) {
          score -= 10;
        } else {
          score -= 5;
        }
      } else if (resp.status == ResponsibilityStatus.completed) {
        // 24-hour cooling off period logic
        final hoursSinceCompletion = DateTime.now().difference(resp.updatedAt).inHours;
        if (hoursSinceCompletion < 24 && resp.confidenceScore < 100) {
          // Score cannot exceed 95 during cooling off if it was previously escalated
          if (score > 95) score = 95;
        }
      }
    }

    return score.clamp(0, 100);
  }
}
