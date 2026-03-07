// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

// Project imports:
import 'package:words625/core/extensions.dart';
import 'package:words625/di/injection.dart';
import 'package:words625/domain/course/course.dart';
import 'package:words625/routing/routing.gr.dart';
import 'package:words625/service/locator.dart';
import 'package:words625/views/theme.dart';

class CourseNode extends StatefulWidget {
  final Course course;
  final int? crown;
  final double? percent;

  const CourseNode(
    this.course, {
    this.crown,
    this.percent,
    Key? key,
  }) : super(key: key);

  @override
  State<CourseNode> createState() => _CourseNodeState();
}

class _CourseNodeState extends State<CourseNode> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final courseColor = widget.course.color != null
        ? Color(widget.course.color!)
        : VarnamalaTheme.peacockCyan;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Column(
        children: [
          GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            onTap: () {
              context.router.push(LessonRoute(course: widget.course));
            },
            child: AnimatedScale(
              scale: _isPressed ? 0.92 : 1.0,
              duration: const Duration(milliseconds: 120),
              child: _CourseIcon(course: widget.course, color: courseColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.course.courseName.toTitleCase,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.2,
                ),
          ),
        ],
      ),
    );
  }
}

class _CourseIcon extends StatelessWidget {
  final Course course;
  final Color color;

  const _CourseIcon({required this.course, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Progress ring
        PreferenceBuilder<int>(
          preference: getIt<AppPrefs>()
              .preferences
              .getInt(course.courseName, defaultValue: 0),
          builder: (BuildContext context, int counter) {
            final numberOfQuestions = course.levels?.length ?? 0;
            final percent =
                numberOfQuestions == 0 ? 0.0 : counter / numberOfQuestions;
            return Transform.rotate(
              angle: -1.57,
              child: CircularPercentIndicator(
                radius: 48.0,
                lineWidth: 5.0,
                percent: percent.clamp(0.0, 1.0),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: VarnamalaTheme.success,
                backgroundColor: VarnamalaTheme.textHint.withValues(alpha: 0.15),
                backgroundWidth: 4,
              ),
            );
          },
        ),
        // Main circle
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                color.withValues(alpha: 0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: _getCourseIcon(course),
          ),
        ),
        // Crown badge
        PreferenceBuilder<int>(
          preference: getIt<AppPrefs>()
              .preferences
              .getInt(course.courseName, defaultValue: 0),
          builder: (BuildContext context, int counter) {
            return Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "$counter",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: VarnamalaTheme.peacockTeal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _getCourseIcon(Course course) {
    // Use Material icons instead of asset images
    final name = course.courseName.toLowerCase();
    IconData icon;
    if (name.contains('basic') || name.contains('intro')) {
      icon = Icons.auto_stories_rounded;
    } else if (name.contains('food') || name.contains('eat')) {
      icon = Icons.restaurant_rounded;
    } else if (name.contains('travel') || name.contains('place')) {
      icon = Icons.flight_rounded;
    } else if (name.contains('family') || name.contains('people')) {
      icon = Icons.family_restroom_rounded;
    } else if (name.contains('number') || name.contains('count')) {
      icon = Icons.pin_rounded;
    } else if (name.contains('animal')) {
      icon = Icons.pets_rounded;
    } else if (name.contains('color') || name.contains('colour')) {
      icon = Icons.palette_rounded;
    } else if (name.contains('greet') || name.contains('hello')) {
      icon = Icons.waving_hand_rounded;
    } else if (name.contains('shop') || name.contains('market')) {
      icon = Icons.shopping_bag_rounded;
    } else if (name.contains('time') || name.contains('day')) {
      icon = Icons.schedule_rounded;
    } else if (name.contains('body') || name.contains('health')) {
      icon = Icons.health_and_safety_rounded;
    } else if (name.contains('weather') || name.contains('nature')) {
      icon = Icons.wb_sunny_rounded;
    } else if (name.contains('school') || name.contains('education')) {
      icon = Icons.school_rounded;
    } else if (name.contains('home') || name.contains('house')) {
      icon = Icons.home_rounded;
    } else if (name.contains('cloth') || name.contains('dress')) {
      icon = Icons.checkroom_rounded;
    } else if (name.contains('verb') || name.contains('action')) {
      icon = Icons.directions_run_rounded;
    } else if (name.contains('phrase')) {
      icon = Icons.chat_bubble_rounded;
    } else {
      icon = Icons.menu_book_rounded;
    }

    return Icon(icon, color: Colors.white, size: 32);
  }
}
