import 'data/services/saved_ai_recipe_sync_service.dart';

class AIRecipeSyncIntegration {
  /// Call this when user successfully logs in
  static Future<void> onUserLogin({
    required String userId,
    required String authToken,
  }) async {
    // Auto-sync saved recipes after login
    await SavedAiRecipeSyncService.autoSyncIfNeeded(
      userId: userId,
      authToken: authToken,
    );
  }

  /// Call this when user saves a new AI recipe
  static Future<void> onRecipeSaved({
    required String userId,
    required String authToken,
  }) async {
    // Sync immediately when a new recipe is saved
    await SavedAiRecipeSyncService.autoSyncIfNeeded(
      userId: userId,
      authToken: authToken,
    );
  }

  /// Call this when app goes to background
  static Future<void> onAppBackground({
    required String userId,
    required String authToken,
  }) async {
    // Sync before app goes to background
    await SavedAiRecipeSyncService.autoSyncIfNeeded(
      userId: userId,
      authToken: authToken,
    );
  }

  /// Manual sync trigger (can be called from UI)
  static Future<Map<String, dynamic>> manualSync({
    required String userId,
    required String authToken,
  }) async {
    return await SavedAiRecipeSyncService.syncSavedRecipesToBackend(
      userId: userId,
      authToken: authToken,
    );
  }

  /// Get sync status for UI display
  static Future<Map<String, dynamic>> getSyncStatus() async {
    return await SavedAiRecipeSyncService.getSyncStatus();
  }
}
