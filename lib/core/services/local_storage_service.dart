import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../config/routes.dart'; // Import temporaire pour sharedPreferencesProvider

// Provider for LocalStorageService
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return LocalStorageService(sharedPrefs);
});

// Keys for storage
class StorageKeys {
  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userProfile = 'user_profile';
  static const String onboardingComplete = 'onboarding_complete';
  static const String lastWorkoutDate = 'last_workout_date';
  static const String currentSubscription = 'current_subscription';
  static const String preferredLanguage = 'preferred_language';
  static const String useMetricUnits = 'use_metric_units';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String workoutReminders = 'workout_reminders';
  static const String soundEnabled = 'sound_enabled';
  static const String vibrationEnabled = 'vibration_enabled';
  static const String restTimerDuration = 'rest_timer_duration';
  static const String cachedExercises = 'cached_exercises';
  static const String cachedPrograms = 'cached_programs';
}

class LocalStorageService {
  final SharedPreferences _prefs;
  static const _secureStorage = FlutterSecureStorage();

  LocalStorageService(this._prefs);

  // Generic methods
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // JSON methods
  Future<bool> setJson(String key, Map<String, dynamic> json) async {
    final jsonString = jsonEncode(json);
    return await setString(key, jsonString);
  }

  Map<String, dynamic>? getJson(String key) {
    final jsonString = getString(key);
    if (jsonString == null) return null;

    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Secure storage methods (for sensitive data)
  Future<void> setSecureString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getSecureString(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteSecureString(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Auth specific methods
  Future<void> saveAuthTokens({
    required String authToken,
    required String refreshToken,
  }) async {
    await setSecureString(StorageKeys.authToken, authToken);
    await setSecureString(StorageKeys.refreshToken, refreshToken);
  }

  Future<String?> getAuthToken() async {
    return await getSecureString(StorageKeys.authToken);
  }

  Future<String?> getRefreshToken() async {
    return await getSecureString(StorageKeys.refreshToken);
  }

  Future<void> clearAuthTokens() async {
    await deleteSecureString(StorageKeys.authToken);
    await deleteSecureString(StorageKeys.refreshToken);
  }

  // User profile methods
  Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    await setJson(StorageKeys.userProfile, profile);
  }

  Map<String, dynamic>? getUserProfile() {
    return getJson(StorageKeys.userProfile);
  }

  // Settings methods
  bool get useMetricUnits => getBool(StorageKeys.useMetricUnits) ?? true;
  bool get notificationsEnabled =>
      getBool(StorageKeys.notificationsEnabled) ?? true;
  bool get soundEnabled => getBool(StorageKeys.soundEnabled) ?? true;
  bool get vibrationEnabled => getBool(StorageKeys.vibrationEnabled) ?? true;
  int get restTimerDuration => getInt(StorageKeys.restTimerDuration) ?? 60;

  // Cache methods
  Future<void> cacheExercises(List<Map<String, dynamic>> exercises) async {
    final jsonString = jsonEncode(exercises);
    await setString(StorageKeys.cachedExercises, jsonString);
  }

  List<Map<String, dynamic>>? getCachedExercises() {
    final jsonString = getString(StorageKeys.cachedExercises);
    if (jsonString == null) return null;

    try {
      final list = jsonDecode(jsonString) as List;
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      return null;
    }
  }

  // Clear methods
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    // Clear SharedPreferences
    final result = await _prefs.clear();

    // Clear SecureStorage
    await _secureStorage.deleteAll();

    return result;
  }

  Future<void> clearUserData() async {
    // Clear user-specific data but keep app settings
    await clearAuthTokens();
    await remove(StorageKeys.userId);
    await remove(StorageKeys.userProfile);
    await remove(StorageKeys.onboardingComplete);
    await remove(StorageKeys.lastWorkoutDate);
    await remove(StorageKeys.currentSubscription);
    await remove(StorageKeys.cachedPrograms);
  }
}
