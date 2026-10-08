import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/app_routes.dart';
import '../domain/entities/math_topic.dart';

/// Navigation helpers for practice mode.
extension PracticeNavigation on BuildContext {
  /// Opens a practice session on [topic], or a recommended mix when `null`.
  void startPractice([MathTopic? topic]) => push(
    Uri(
      path: AppRoutes.practiceSession,
      queryParameters: topic == null
          ? null
          : {AppRoutes.topicParam: topic.name},
    ).toString(),
  );
}
