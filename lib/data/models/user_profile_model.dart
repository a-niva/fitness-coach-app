import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

// Enums
enum FitnessLevel { beginner, intermediate, advanced, elite, extreme }

enum FitnessGoal {
  muscleGain,
  strengthBuilding,
  weightLoss,
  cardiovascularEndurance,
  bodyRecomposition,
  athleticPerformance,
}

enum TrainingPreference {
  trainingToFailure,
  highIntensityCardio,
  upperBodyFocus,
  lowerBodyFocus,
  coreFocus,
  functionalFitness,
  powerlifting,
  bodybuilding,
}

// Equipment model
@freezed
class Equipment with _$Equipment {
  const factory Equipment({
    required String type,
    required List<double> weights,
  }) = _Equipment;

  factory Equipment.fromJson(Map<String, dynamic> json) =>
      _$EquipmentFromJson(json);
}

// User profile model
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String email,
    required int age,
    required FitnessLevel level,
    required Map<String, Equipment> equipment,
    required List<FitnessGoal> goals,
    required List<TrainingPreference> preferences,
    required DateTime createdAt,
    DateTime? lastWorkout,
    @Default(true) bool useMetricUnits,
    @Default('en') String preferredLanguage,
    String? firstName,
    String? lastName,
    double? height,
    double? weight,
    String? profilePicture,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  // Helper method to get formatted display name
  const UserProfile._();

  String get displayName {
    if (firstName != null || lastName != null) {
      return '${firstName ?? ''} ${lastName ?? ''}'.trim();
    }
    return email.split('@').first;
  }

  // Helper to check if profile is complete
  bool get isProfileComplete {
    return equipment.isNotEmpty && goals.isNotEmpty && preferences.isNotEmpty;
  }

  // Helper to get primary goal
  FitnessGoal? get primaryGoal => goals.isNotEmpty ? goals.first : null;

  // Convert height/weight based on units
  String get formattedHeight {
    if (height == null) return '--';
    if (useMetricUnits) {
      return '${height!.toStringAsFixed(0)} cm';
    } else {
      final feet = (height! * 0.0328084).floor();
      final inches = ((height! * 0.393701) % 12).round();
      return '$feet\'$inches"';
    }
  }

  String get formattedWeight {
    if (weight == null) return '--';
    if (useMetricUnits) {
      return '${weight!.toStringAsFixed(1)} kg';
    } else {
      return '${(weight! * 2.20462).toStringAsFixed(1)} lbs';
    }
  }
}

// Extension methods for enums
extension FitnessLevelExtension on FitnessLevel {
  String get displayName {
    switch (this) {
      case FitnessLevel.beginner:
        return 'Beginner';
      case FitnessLevel.intermediate:
        return 'Intermediate';
      case FitnessLevel.advanced:
        return 'Advanced';
      case FitnessLevel.elite:
        return 'Elite';
      case FitnessLevel.extreme:
        return 'Extreme';
    }
  }

  String get description {
    switch (this) {
      case FitnessLevel.beginner:
        return 'New to fitness (0-6 months)';
      case FitnessLevel.intermediate:
        return 'Regular training (6-24 months)';
      case FitnessLevel.advanced:
        return 'Experienced (2-5 years)';
      case FitnessLevel.elite:
        return 'Highly trained (5+ years)';
      case FitnessLevel.extreme:
        return 'Professional athlete level';
    }
  }
}

extension FitnessGoalExtension on FitnessGoal {
  String get displayName {
    switch (this) {
      case FitnessGoal.muscleGain:
        return 'Muscle Gain';
      case FitnessGoal.strengthBuilding:
        return 'Strength Building';
      case FitnessGoal.weightLoss:
        return 'Weight Loss';
      case FitnessGoal.cardiovascularEndurance:
        return 'Cardio Endurance';
      case FitnessGoal.bodyRecomposition:
        return 'Body Recomposition';
      case FitnessGoal.athleticPerformance:
        return 'Athletic Performance';
    }
  }

  String get icon {
    switch (this) {
      case FitnessGoal.muscleGain:
        return '💪';
      case FitnessGoal.strengthBuilding:
        return '🏋️';
      case FitnessGoal.weightLoss:
        return '⚖️';
      case FitnessGoal.cardiovascularEndurance:
        return '🏃';
      case FitnessGoal.bodyRecomposition:
        return '🔄';
      case FitnessGoal.athleticPerformance:
        return '🏆';
    }
  }
}

extension TrainingPreferenceExtension on TrainingPreference {
  String get displayName {
    switch (this) {
      case TrainingPreference.trainingToFailure:
        return 'Training to Failure';
      case TrainingPreference.highIntensityCardio:
        return 'High Intensity Cardio';
      case TrainingPreference.upperBodyFocus:
        return 'Upper Body Focus';
      case TrainingPreference.lowerBodyFocus:
        return 'Lower Body Focus';
      case TrainingPreference.coreFocus:
        return 'Core Focus';
      case TrainingPreference.functionalFitness:
        return 'Functional Fitness';
      case TrainingPreference.powerlifting:
        return 'Powerlifting';
      case TrainingPreference.bodybuilding:
        return 'Bodybuilding';
    }
  }
}
