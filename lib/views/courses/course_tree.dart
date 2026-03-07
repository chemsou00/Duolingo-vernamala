// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:words625/application/course_provider.dart';
import 'package:words625/application/language_provider.dart';
import 'package:words625/views/theme.dart';
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
        gradient: VarnamalaTheme.courseTreeGradient,
      ),
      child: Consumer<CourseProvider>(
        builder: (context, courseState, _) {
          final courses = courseState.courses;

          if (courses == null) {
            return const Center(child: _LoadingIndicator());
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 24, bottom: 40),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Even indices are course groups, odd indices are connectors
                      final courseIndex = index ~/ 2;
                      final isConnector = index.isOdd;

                      if (isConnector) {
                        if (courseIndex >= courses.length) {
                          return const SizedBox.shrink();
                        }
                        return _buildPathConnector();
                      }

                      if (courseIndex >= courses.length) {
                        return const SizedBox.shrink();
                      }

                      final courseGroup = courses[courseIndex];
                      if (courseGroup.length == 1) {
                        return CourseNode(courseGroup[0], crown: 1);
                      } else if (courseGroup.length == 2) {
                        return DoubleCourseNode(
                          CourseNode(courseGroup[0], crown: 1),
                          CourseNode(courseGroup[1], crown: 1),
                        );
                      } else if (courseGroup.length == 3) {
                        return TripleCourseNode(
                          CourseNode(courseGroup[0]),
                          CourseNode(courseGroup[1]),
                          CourseNode(courseGroup[2]),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    childCount: courses.isEmpty ? 0 : courses.length * 2 - 1,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPathConnector() {
    return Center(
      child: Container(
        width: 3,
        height: 28,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              VarnamalaTheme.peacockTeal.withValues(alpha: 0.3),
              VarnamalaTheme.peacockTeal.withValues(alpha: 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              VarnamalaTheme.peacockTeal.withValues(alpha: 0.7),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Loading courses...',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: VarnamalaTheme.textHint,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
