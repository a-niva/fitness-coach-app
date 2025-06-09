class AppConfig {
  static const String appName = 'FitCoach AI';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:8000/api/v1',
  );

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Workout Configuration
  static const int minRestTime = 15; // seconds
  static const int maxRestTime = 300; // seconds
  static const int defaultRestTime = 60; // seconds

  // ML Configuration
  static const double minConfidenceThreshold = 0.7;
  static const int maxPredictionHorizon = 4; // weeks

  // Subscription Tiers
  static const Map<String, SubscriptionTier> subscriptionTiers = {
    'free': SubscriptionTier(
      id: 'free',
      name: 'Free',
      price: 0,
      features: [
        'Free Time Mode',
        'Basic Progress Tracking',
        'Limited Exercise Library',
      ],
      limitations: {'workoutsPerWeek': 3, 'exercisesInLibrary': 50},
    ),
    'premium': SubscriptionTier(
      id: 'premium',
      name: 'Premium',
      price: 9.99,
      features: [
        'All Free Features',
        'Program Mode with ML',
        'Full Exercise Library',
        'Advanced Analytics',
        'Unlimited Workouts',
      ],
      limitations: {},
    ),
    'pro': SubscriptionTier(
      id: 'pro',
      name: 'Pro',
      price: 19.99,
      features: [
        'All Premium Features',
        'Personalized Nutrition Plans',
        'Priority Support',
        'Export Data',
        'Advanced ML Predictions',
      ],
      limitations: {},
    ),
  };

  // Feature Flags
  static const Map<String, bool> featureFlags = {
    'enableMLPredictions': true,
    'enableGamification': true,
    'enableSocialFeatures': false,
    'enableNutritionTracking': false,
    'enableWearableIntegration': false,
  };

  // Cache Configuration
  static const Duration cacheMaxAge = Duration(hours: 24);
  static const int cacheMaxSize = 100 * 1024 * 1024; // 100MB

  // Development
  static const bool isDevelopment =
      bool.fromEnvironment('dart.vm.product') == false;
  static const bool enableLogging = isDevelopment;
  static const bool enableMockData = false;
}

class SubscriptionTier {
  final String id;
  final String name;
  final double price;
  final List<String> features;
  final Map<String, dynamic> limitations;

  const SubscriptionTier({
    required this.id,
    required this.name,
    required this.price,
    required this.features,
    required this.limitations,
  });
}
