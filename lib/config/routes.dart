import 'package:flutter/material.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/home/dashboard_screen.dart';
import '../presentation/screens/onboarding/profile_basic_screen.dart';
import '../presentation/screens/onboarding/equipment_selection_screen.dart';
import '../presentation/screens/onboarding/goals_selection_screen.dart';
import '../presentation/screens/onboarding/preferences_screen.dart';
import '../presentation/screens/workout/mode_selection_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String onboardingProfile = '/onboarding/profile';
  static const String onboardingEquipment = '/onboarding/equipment';
  static const String onboardingGoals = '/onboarding/goals';
  static const String onboardingPreferences = '/onboarding/preferences';
  static const String workoutModeSelection = '/workout/mode-selection';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case onboardingProfile:
        return MaterialPageRoute(builder: (_) => const ProfileBasicScreen());
      case onboardingEquipment:
        return MaterialPageRoute(builder: (_) => const EquipmentSelectionScreen());
      case onboardingGoals:
        return MaterialPageRoute(builder: (_) => const GoalsSelectionScreen());
      case onboardingPreferences:
        return MaterialPageRoute(builder: (_) => const PreferencesScreen());
      case workoutModeSelection:
        return MaterialPageRoute(builder: (_) => const ModeSelectionScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route not found: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
