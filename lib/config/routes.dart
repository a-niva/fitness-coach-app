import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/onboarding/profile_basic_screen.dart';
import '../presentation/screens/onboarding/equipment_selection_screen.dart';
import '../presentation/screens/onboarding/goals_selection_screen.dart';
import '../presentation/screens/onboarding/preferences_screen.dart';
import '../presentation/screens/home/dashboard_screen.dart';
import '../presentation/screens/workout/mode_selection_screen.dart';
import '../presentation/screens/workout/free_time/exercise_search_screen.dart';
import '../presentation/screens/workout/free_time/live_counter_screen.dart';
import '../presentation/providers/auth_provider.dart';

// Route names
class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String onboardingProfile = '/onboarding/profile';
  static const String onboardingEquipment = '/onboarding/equipment';
  static const String onboardingGoals = '/onboarding/goals';
  static const String onboardingPreferences = '/onboarding/preferences';
  static const String dashboard = '/';
  static const String workoutMode = '/workout/mode';
  static const String exerciseSearch = '/workout/free/search';
  static const String liveCounter = '/workout/free/counter';
}

// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isLoggingIn = state.matchedLocation == AppRoutes.login;
      final isRegistering = state.matchedLocation == AppRoutes.register;
      final isOnboarding = state.matchedLocation.startsWith('/onboarding');

      // Not logged in, trying to access protected route
      if (!isLoggedIn && !isLoggingIn && !isRegistering && !isOnboarding) {
        return AppRoutes.login;
      }

      // Logged in but trying to access auth pages
      if (isLoggedIn && (isLoggingIn || isRegistering)) {
        return AppRoutes.dashboard;
      }

      // Check if onboarding is complete
      if (isLoggedIn && authState.value?.isOnboardingComplete == false) {
        if (!isOnboarding) {
          return AppRoutes.onboardingProfile;
        }
      }

      return null;
    },
    routes: [
      // Auth routes
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      // Onboarding flow
      GoRoute(
        path: AppRoutes.onboardingProfile,
        builder: (context, state) => const ProfileBasicScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingEquipment,
        builder: (context, state) => const EquipmentSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingGoals,
        builder: (context, state) => const GoalsSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingPreferences,
        builder: (context, state) => const PreferencesScreen(),
      ),

      // Main app routes
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.workoutMode,
        builder: (context, state) => const ModeSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.exerciseSearch,
        builder: (context, state) => const ExerciseSearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.liveCounter,
        builder: (context, state) {
          final exerciseId = state.uri.queryParameters['exerciseId'];
          if (exerciseId == null) {
            return const ExerciseSearchScreen();
          }
          return LiveCounterScreen(exerciseId: exerciseId);
        },
      ),
    ],

    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.error?.toString() ?? 'Unknown error',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.dashboard),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
