import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../providers/shared_preferences_provider.dart'; // AJOUTER CETTE LIGNE

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // Basic storage methods
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }

  // Auth-specific methods
  String? getAuthToken() {
    return getString(StorageKeys.authToken);
  }

  Future<bool> saveAuthTokens({
    required String authToken,
    String? refreshToken,
  }) async {
    final success1 = await setString(StorageKeys.authToken, authToken);
    bool success2 = true;
    if (refreshToken != null) {
      success2 = await setString(StorageKeys.refreshToken, refreshToken);
    }
    return success1 && success2;
  }

  Future<String?> getRefreshToken() async {
    return getString(StorageKeys.refreshToken);
  }

  Map<String, dynamic>? getUserProfile() {
    final profileString = getString(StorageKeys.userProfile);
    if (profileString != null) {
      try {
        return jsonDecode(profileString) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<bool> saveUserProfile(Map<String, dynamic> profile) async {
    try {
      final profileString = jsonEncode(profile);
      return await setString(StorageKeys.userProfile, profileString);
    } catch (e) {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    return getBool(StorageKeys.isLoggedIn) ?? false;
  }

  Future<bool> setLoggedIn(bool value) async {
    return await setBool(StorageKeys.isLoggedIn, value);
  }

  Future<String?> getUserId() async {
    return getString(StorageKeys.userId);
  }

  Future<bool> saveUserId(String userId) async {
    return await setString(StorageKeys.userId, userId);
  }

  Future<bool> clearUserData() async {
    final futures = [
      remove(StorageKeys.authToken),
      remove(StorageKeys.refreshToken),
      remove(StorageKeys.userProfile),
      remove(StorageKeys.isLoggedIn),
      remove(StorageKeys.userId),
      remove(StorageKeys.userName),
      remove(StorageKeys.userEmail),
    ];

    final results = await Future.wait(futures);
    return results.every((result) => result == true);
  }
}

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalStorageService(prefs);
});
