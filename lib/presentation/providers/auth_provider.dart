import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_profile_model.dart';
import '../../core/services/local_storage_service.dart';
import '../../core/constants/app_constants.dart';

// Auth state model
class AuthState {
  final String userId;
  final String email;
  final bool isOnboardingComplete;
  final UserProfile? profile;

  AuthState({
    required this.userId,
    required this.email,
    required this.isOnboardingComplete,
    this.profile,
  });

  AuthState copyWith({
    String? userId,
    String? email,
    bool? isOnboardingComplete,
    UserProfile? profile,
  }) {
    return AuthState(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
      profile: profile ?? this.profile,
    );
  }
}

// Auth state provider
final authStateProvider = StreamProvider<AuthState?>((ref) {
  final authNotifier = ref.watch(authNotifierProvider.notifier);
  return authNotifier.authStateStream;
});

// Auth notifier provider
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<AuthState?>>((ref) {
  final localStorage = ref.watch(localStorageServiceProvider);
  return AuthNotifier(localStorage);
});

class AuthNotifier extends StateNotifier<AsyncValue<AuthState?>> {
  final LocalStorageService _localStorage;
  final _authStateController = StreamController<AuthState?>.broadcast();

  AuthNotifier(this._localStorage) : super(const AsyncValue.loading()) {
    _checkAuthStatus();
  }

  Stream<AuthState?> get authStateStream => _authStateController.stream;

  Future<void> _checkAuthStatus() async {
    try {
      final token = await _localStorage.getAuthToken();
      final userId = _localStorage.getString(StorageKeys.userId);
      final userProfileJson = _localStorage.getUserProfile();
      final isOnboardingComplete =
          _localStorage.getBool(StorageKeys.onboardingComplete) ?? false;

      if (token != null && userId != null) {
        UserProfile? profile;
        if (userProfileJson != null) {
          profile = UserProfile.fromJson(userProfileJson);
        }

        final authState = AuthState(
          userId: userId,
          email: userProfileJson?['email'] ?? '',
          isOnboardingComplete: isOnboardingComplete,
          profile: profile,
        );

        state = AsyncValue.data(authState);
        _authStateController.add(authState);
      } else {
        state = const AsyncValue.data(null);
        _authStateController.add(null);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      _authStateController.add(null);
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();

    try {
      // TODO: Implement actual API call
      // For now, simulate login
      await Future.delayed(const Duration(seconds: 1));

      // Simulate successful login
      const userId = 'mock_user_id';
      const authToken = 'mock_auth_token';
      const refreshToken = 'mock_refresh_token';

      // Save tokens
      await _localStorage.saveAuthTokens(
        authToken: authToken,
        refreshToken: refreshToken,
      );
      await _localStorage.setString(StorageKeys.userId, userId);

      // Check if user has completed onboarding
      final isOnboardingComplete =
          _localStorage.getBool(StorageKeys.onboardingComplete) ?? false;

      final authState = AuthState(
        userId: userId,
        email: email,
        isOnboardingComplete: isOnboardingComplete,
      );

      state = AsyncValue.data(authState);
      _authStateController.add(authState);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    try {
      // TODO: Implement actual API call
      // For now, simulate registration
      await Future.delayed(const Duration(seconds: 1));

      // Simulate successful registration
      const userId = 'new_user_id';
      const authToken = 'new_auth_token';
      const refreshToken = 'new_refresh_token';

      // Save tokens
      await _localStorage.saveAuthTokens(
        authToken: authToken,
        refreshToken: refreshToken,
      );
      await _localStorage.setString(StorageKeys.userId, userId);
      await _localStorage.setBool(StorageKeys.onboardingComplete, false);

      final authState = AuthState(
        userId: userId,
        email: email,
        isOnboardingComplete: false,
      );

      state = AsyncValue.data(authState);
      _authStateController.add(authState);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  Future<void> updateProfile(UserProfile profile) async {
    final currentState = state.value;
    if (currentState == null) return;

    try {
      // Save profile to local storage
      await _localStorage.saveUserProfile(profile.toJson());

      // Update state
      final newState = currentState.copyWith(profile: profile);
      state = AsyncValue.data(newState);
      _authStateController.add(newState);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> completeOnboarding() async {
    final currentState = state.value;
    if (currentState == null) return;

    try {
      await _localStorage.setBool(StorageKeys.onboardingComplete, true);

      final newState = currentState.copyWith(isOnboardingComplete: true);
      state = AsyncValue.data(newState);
      _authStateController.add(newState);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> logout() async {
    try {
      await _localStorage.clearUserData();
      state = const AsyncValue.data(null);
      _authStateController.add(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  void dispose() {
    _authStateController.close();
    super.dispose();
  }
}
