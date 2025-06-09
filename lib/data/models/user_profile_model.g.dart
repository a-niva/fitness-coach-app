// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EquipmentImpl _$$EquipmentImplFromJson(Map<String, dynamic> json) =>
    _$EquipmentImpl(
      type: json['type'] as String,
      weights: (json['weights'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$$EquipmentImplToJson(_$EquipmentImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'weights': instance.weights,
    };

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      age: (json['age'] as num).toInt(),
      level: $enumDecode(_$FitnessLevelEnumMap, json['level']),
      equipment: (json['equipment'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Equipment.fromJson(e as Map<String, dynamic>)),
      ),
      goals: (json['goals'] as List<dynamic>)
          .map((e) => $enumDecode(_$FitnessGoalEnumMap, e))
          .toList(),
      preferences: (json['preferences'] as List<dynamic>)
          .map((e) => $enumDecode(_$TrainingPreferenceEnumMap, e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastWorkout: json['lastWorkout'] == null
          ? null
          : DateTime.parse(json['lastWorkout'] as String),
      useMetricUnits: json['useMetricUnits'] as bool? ?? true,
      preferredLanguage: json['preferredLanguage'] as String? ?? 'en',
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'age': instance.age,
      'level': _$FitnessLevelEnumMap[instance.level]!,
      'equipment': instance.equipment,
      'goals': instance.goals.map((e) => _$FitnessGoalEnumMap[e]!).toList(),
      'preferences': instance.preferences
          .map((e) => _$TrainingPreferenceEnumMap[e]!)
          .toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'lastWorkout': instance.lastWorkout?.toIso8601String(),
      'useMetricUnits': instance.useMetricUnits,
      'preferredLanguage': instance.preferredLanguage,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'height': instance.height,
      'weight': instance.weight,
      'profilePicture': instance.profilePicture,
    };

const _$FitnessLevelEnumMap = {
  FitnessLevel.beginner: 'beginner',
  FitnessLevel.intermediate: 'intermediate',
  FitnessLevel.advanced: 'advanced',
  FitnessLevel.elite: 'elite',
  FitnessLevel.extreme: 'extreme',
};

const _$FitnessGoalEnumMap = {
  FitnessGoal.muscleGain: 'muscleGain',
  FitnessGoal.strengthBuilding: 'strengthBuilding',
  FitnessGoal.weightLoss: 'weightLoss',
  FitnessGoal.cardiovascularEndurance: 'cardiovascularEndurance',
  FitnessGoal.bodyRecomposition: 'bodyRecomposition',
  FitnessGoal.athleticPerformance: 'athleticPerformance',
};

const _$TrainingPreferenceEnumMap = {
  TrainingPreference.trainingToFailure: 'trainingToFailure',
  TrainingPreference.highIntensityCardio: 'highIntensityCardio',
  TrainingPreference.upperBodyFocus: 'upperBodyFocus',
  TrainingPreference.lowerBodyFocus: 'lowerBodyFocus',
  TrainingPreference.coreFocus: 'coreFocus',
  TrainingPreference.functionalFitness: 'functionalFitness',
  TrainingPreference.powerlifting: 'powerlifting',
  TrainingPreference.bodybuilding: 'bodybuilding',
};
