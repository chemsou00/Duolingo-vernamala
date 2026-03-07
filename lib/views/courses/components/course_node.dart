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
        : const Color(0xFF2B70C9);

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
              scale: _isPressed ? 0.95 : 1.0,
              duration: const Duration(milliseconds: 100),
              child: _CourseIcon(course: widget.course, color: courseColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.course.courseName.toTitleCase,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF374151),
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
            final percent = numberOfQuestions == 0 ? 0.0 : counter / numberOfQuestions;
            return Transform.rotate(
              angle: -1.57, // Start from top
              child: CircularPercentIndicator(
                radius: 48.0,
                lineWidth: 5.0,
                percent: percent,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: const Color(0xFFFFD700),
                backgroundColor: const Color(0xFFE5E7EB),
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
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              course.image ?? 'assets/images/egg.png',
              width: 40,
              height: 40,
            ),
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
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/crown.png', width: 32),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        "$counter",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFFB66E28),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
