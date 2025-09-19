import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/ai_meal.dart';

class SavedAiRecipeSyncService {
  static const String _baseUrl =
      'http://10.0.2.2:8190/api'; // Android emulator localhost
  static const String _recipesKey = 'ai_recipes';

  /// Sync saved AI recipes from local storage to backend
  static Future<Map<String, dynamic>> syncSavedRecipesToBackend({
    required String userId,
    required String authToken,
  }) async {
    try {
      // Get saved recipes from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final recipesString = prefs.getString(_recipesKey);

      if (recipesString == null) {
        return {'success': false, 'message': 'No saved recipes found locally'};
      }

      // Parse saved recipes
      final List<dynamic> recipesJson = json.decode(recipesString);
      final List<AIMeal> savedRecipes = recipesJson
          .where((json) => json != null)
          .map((json) => AIMeal.fromJson(json as Map<String, dynamic>))
          .toList();

      if (savedRecipes.isEmpty) {
        return {'success': false, 'message': 'No saved recipes to sync'};
      }

      // Get device info
      final deviceInfo = await _getDeviceInfo();

      // Prepare sync data
      final syncData = {
        'userId': userId,
        'savedRecipes': savedRecipes.map((recipe) => recipe.toJson()).toList(),
        'deviceInfo': deviceInfo,
      };

      // Send sync request to backend
      final response = await http.post(
        Uri.parse('$_baseUrl/syncSavedAiRecipes'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(syncData),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        // Mark recipes as synced locally (optional)
        await _markRecipesAsSynced(savedRecipes);

        return {
          'success': true,
          'message': 'Recipes synced successfully',
          'data': responseData['data']
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Sync failed'
        };
      }
    } catch (e) {
      print('Error syncing saved recipes: $e');
      return {
        'success': false,
        'message': 'Error syncing recipes: ${e.toString()}'
      };
    }
  }

  /// Get device information for tracking (simplified version)
  static Future<Map<String, String>> _getDeviceInfo() async {
    try {
      return {
        'platform': Platform.operatingSystem,
        'version': Platform.operatingSystemVersion,
        'model': 'Flutter App',
        'device': 'Mobile Device',
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'platform': 'Unknown',
        'version': 'Unknown',
        'model': 'Unknown',
        'device': 'Unknown',
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }

  /// Mark recipes as synced (add sync timestamp)
  static Future<void> _markRecipesAsSynced(List<AIMeal> recipes) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final syncTimestamp = DateTime.now().toIso8601String();

      // Add sync info to each recipe
      final updatedRecipes = recipes.map((recipe) {
        final recipeJson = recipe.toJson();
        recipeJson['lastSyncAt'] = syncTimestamp;
        return recipeJson;
      }).toList();

      await prefs.setString(_recipesKey, json.encode(updatedRecipes));
    } catch (e) {
      print('Error marking recipes as synced: $e');
    }
  }

  /// Check if recipes need to be synced
  static Future<bool> needsSync() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final recipesString = prefs.getString(_recipesKey);

      if (recipesString == null) return false;

      final List<dynamic> recipesJson = json.decode(recipesString);

      // Check if any recipe hasn't been synced or was modified after last sync
      for (final recipeJson in recipesJson) {
        if (recipeJson['lastSyncAt'] == null) {
          return true; // Recipe never synced
        }

        final lastSync = DateTime.parse(recipeJson['lastSyncAt']);
        final created = DateTime.parse(recipeJson['createdAt']);

        if (created.isAfter(lastSync)) {
          return true; // Recipe modified after last sync
        }
      }

      return false;
    } catch (e) {
      print('Error checking sync status: $e');
      return true; // Default to needing sync on error
    }
  }

  /// Auto-sync recipes periodically or on app events
  static Future<void> autoSyncIfNeeded({
    required String userId,
    required String authToken,
  }) async {
    try {
      if (await needsSync()) {
        print('Auto-syncing saved AI recipes...');
        final result = await syncSavedRecipesToBackend(
          userId: userId,
          authToken: authToken,
        );

        if (result['success']) {
          print('Auto-sync successful: ${result['message']}');
        } else {
          print('Auto-sync failed: ${result['message']}');
        }
      }
    } catch (e) {
      print('Error in auto-sync: $e');
    }
  }

  /// Get sync status info
  static Future<Map<String, dynamic>> getSyncStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final recipesString = prefs.getString(_recipesKey);

      if (recipesString == null) {
        return {
          'totalRecipes': 0,
          'syncedRecipes': 0,
          'unsyncedRecipes': 0,
          'lastSyncAt': null,
        };
      }

      final List<dynamic> recipesJson = json.decode(recipesString);
      int syncedCount = 0;
      DateTime? lastSync;

      for (final recipeJson in recipesJson) {
        if (recipeJson['lastSyncAt'] != null) {
          syncedCount++;
          final syncTime = DateTime.parse(recipeJson['lastSyncAt']);
          if (lastSync == null || syncTime.isAfter(lastSync)) {
            lastSync = syncTime;
          }
        }
      }

      return {
        'totalRecipes': recipesJson.length,
        'syncedRecipes': syncedCount,
        'unsyncedRecipes': recipesJson.length - syncedCount,
        'lastSyncAt': lastSync?.toIso8601String(),
      };
    } catch (e) {
      print('Error getting sync status: $e');
      return {
        'totalRecipes': 0,
        'syncedRecipes': 0,
        'unsyncedRecipes': 0,
        'lastSyncAt': null,
      };
    }
  }
}
