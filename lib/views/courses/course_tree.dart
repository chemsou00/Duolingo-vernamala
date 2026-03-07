// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:words625/application/course_provider.dart';
import 'package:words625/application/language_provider.dart';
import 'components/course_node.dart';
import 'components/double_course_node.dart';
import 'components/triple_course_node.dart';

class CourseTree extends StatefulWidget {
  const CourseTree({Key? key}) : super(key: key);

  @override
  State<CourseTree> createState() => _CourseTreeState();
}

class _CourseTreeState extends State<CourseTree> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final language = context.read<LanguageProvider>().selectedLanguage;
      context.read<CourseProvider>().getCourses(language);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // Subtle sky-inspired gradient - elegant, not cartoonish
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8FCFF), // Very light blue-white at top
            Color(0xFFF5FAFA), // Subtle teal tint
            Color(0xFFF0F8F6), // Soft sage at bottom
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Consumer<CourseProvider>(
              builder: (context, courseState, _) {
                final courses = courseState.courses;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: courses == null
                        ? [
                            const SizedBox(height: 100),
                            const _LoadingIndicator(),
                          ]
                        : [
                            ...courses.asMap().entries.map<Widget>((entry) {
                              final index = entry.key;
                              final courseGroup = entry.value;
                              final isLast = index == courses.length - 1;
                              
                              Widget courseWidget;
                              if (courseGroup.length == 1) {
                                courseWidget = CourseNode(
                                  courseGroup[0],
                                  crown: 1,
                                );
                              } else if (courseGroup.length == 2) {
                                courseWidget = DoubleCourseNode(
                                  CourseNode(courseGroup[0], crown: 1),
                                  CourseNode(courseGroup[1], crown: 1),
                                );
                              } else if (courseGroup.length == 3) {
                                courseWidget = TripleCourseNode(
                                  CourseNode(courseGroup[0]),
                                  CourseNode(courseGroup[1]),
                                  CourseNode(courseGroup[2]),
                                );
                              } else {
                                courseWidget = Container();
                              }
                              
                              return Column(
                                children: [
                                  courseWidget,
                                  if (!isLast) _buildPathConnector(),
                                ],
                              );
                            }),
                            const SizedBox(height: 40),
                          ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPathConnector() {
    return Container(
      width: 3,
      height: 28,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFD0D5DD),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

/// Animated loading indicator
class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              const Color(0xFF1F727E).withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Loading courses...',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
