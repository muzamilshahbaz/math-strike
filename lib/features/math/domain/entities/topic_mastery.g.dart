// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_mastery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TopicMastery _$TopicMasteryFromJson(Map<String, dynamic> json) =>
    _TopicMastery(
      rating: (json['rating'] as num).toDouble(),
      attempts: (json['attempts'] as num?)?.toInt() ?? 0,
      correct: (json['correct'] as num?)?.toInt() ?? 0,
      recent:
          (json['recent'] as List<dynamic>?)?.map((e) => e as bool).toList() ??
          const <bool>[],
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      lastPracticedAt: json['lastPracticedAt'] == null
          ? null
          : DateTime.parse(json['lastPracticedAt'] as String),
    );

Map<String, dynamic> _$TopicMasteryToJson(_TopicMastery instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'attempts': instance.attempts,
      'correct': instance.correct,
      'recent': instance.recent,
      'streak': instance.streak,
      'lastPracticedAt': ?instance.lastPracticedAt?.toIso8601String(),
    };

_LearningProgress _$LearningProgressFromJson(Map<String, dynamic> json) =>
    _LearningProgress(
      topics:
          (json['topics'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, TopicMastery.fromJson(e as Map<String, dynamic>)),
          ) ??
          const <String, TopicMastery>{},
    );

Map<String, dynamic> _$LearningProgressToJson(_LearningProgress instance) =>
    <String, dynamic>{
      'topics': instance.topics.map((k, e) => MapEntry(k, e.toJson())),
    };
