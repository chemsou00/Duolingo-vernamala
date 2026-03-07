// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/annotations.dart';
import 'package:chiclet/chiclet.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:words625/application/level_provider.dart';
import 'package:words625/domain/course/course.dart';
import 'package:words625/views/lesson/components/lesson_app_bar.dart';
import 'package:words625/views/lesson/components/list_lesson.dart';
import 'package:words625/views/theme.dart';

enum LessonAvailability { loading, present, absent }

@RoutePage()
class LessonPage extends StatefulWidget {
  final Course course;
  const LessonPage({Key? key, required this.course}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LessonPageState();
}

class LessonPageState extends State<LessonPage> {
  double percent = 0.1;
  int index = 0;
  List<ListLesson>? lessons;
  LessonAvailability lessonAvailability = LessonAvailability.loading;

  @override
  void initState() {
    super.initState();
    generateQuestions();
  }

  Future<void> generateQuestions() async {
    if (widget.course.levels == null || widget.course.levels!.isEmpty) {
      setState(() => lessonAvailability = LessonAvailability.absent);
      return;
    }

    final List<ListLesson> generatedLessons = widget
        .course.levels!.first.questions!
        .map((question) => ListLesson(question, course: widget.course))
        .toList();

    setState(() {
      lessonAvailability = generatedLessons.isEmpty
          ? LessonAvailability.absent
          : LessonAvailability.present;
      lessons = generatedLessons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: lessonAvailability == LessonAvailability.present
          ? const LessonAppBar()
          : null,
      body: Builder(
        builder: (context) {
          switch (lessonAvailability) {
            case LessonAvailability.loading:
              return const Center(
                child: CircularProgressIndicator(
                  color: VarnamalaTheme.peacockTeal,
                  strokeWidth: 3,
                ),
              );
            case LessonAvailability.present:
              return lessons![index];
            case LessonAvailability.absent:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu_book_rounded,
                        size: 64,
                        color:
                            VarnamalaTheme.textHint.withValues(alpha: 0.3)),
                    const SizedBox(height: 16),
                    Text(
                      'No lessons available',
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: VarnamalaTheme.textHint,
                              ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}

class CheckButton extends StatelessWidget {
  const CheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Consumer<LessonProvider>(
        builder: (context, lessonState, child) {
          String title;
          Color backgroundColor;

          if (lessonState.answerState == AnswerState.correct ||
              lessonState.answerState == AnswerState.readyForNext) {
            title = "CONTINUE";
            backgroundColor = VarnamalaTheme.peacockTurquoise;
          } else if (lessonState.answerState == AnswerState.incorrect) {
            title = "GOT IT";
            backgroundColor = VarnamalaTheme.error;
          } else {
            title = "CHECK";
            backgroundColor = VarnamalaTheme.peacockTeal;
          }

          final isEnabled = lessonState.selectedAnswer != null;

          return ChicletAnimatedButton(
            width: MediaQuery.of(context).size.width - 40,
            backgroundColor:
                isEnabled ? backgroundColor : const Color(0xFFEEF2F1),
            onPressed: isEnabled
                ? () {
                    if (lessonState.answerState != AnswerState.readyForNext) {
                      final checkAnswer = lessonState.checkAnswer();
                      if (checkAnswer) {
                        if (lessonState.answerState == AnswerState.correct) {
                          lessonState
                              .changeAnswerState(AnswerState.readyForNext);
                        }
                      }
                    } else if (lessonState.answerState ==
                        AnswerState.readyForNext) {
                      lessonState.next(context);
                    }
                  }
                : null,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color:
                    isEnabled ? Colors.white : VarnamalaTheme.textHint,
                letterSpacing: 0.5,
              ),
            ),
          );
        },
      ),
    );
  }
}

class LevelPlayerChoice extends StatelessWidget {
  const LevelPlayerChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(VarnamalaTheme.radiusXLarge)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    VarnamalaTheme.peacockTurquoise.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.celebration_rounded,
                color: VarnamalaTheme.peacockTurquoise,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Level Complete!",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              "Great job on finishing this level.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Continue',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                "Back to Courses",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: VarnamalaTheme.textHint,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCompletionPlayerChoice extends StatelessWidget {
  const CourseCompletionPlayerChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(VarnamalaTheme.radiusXLarge)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: VarnamalaTheme.success.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                color: VarnamalaTheme.successDark,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Course Complete!",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              "You've mastered all the lessons.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Practice Again',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                "Back to Courses",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: VarnamalaTheme.textHint,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
