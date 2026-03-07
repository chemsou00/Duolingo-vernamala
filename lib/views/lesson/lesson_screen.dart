// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/annotations.dart';
import 'package:chiclet/chiclet.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:words625/application/level_provider.dart';
import 'package:words625/core/logger.dart';
import 'package:words625/domain/course/course.dart';
import 'package:words625/views/lesson/components/lesson_app_bar.dart';
import 'package:words625/views/lesson/components/list_lesson.dart';

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
      appBar: lessonAvailability == LessonAvailability.present
          ? const LessonAppBar()
          : null,
      body: Builder(
        builder: (context) {
          switch (lessonAvailability) {
            case LessonAvailability.loading:
              return const Center(child: CircularProgressIndicator());
            case LessonAvailability.present:
              return lessons![index];
            case LessonAvailability.absent:
              return const Center(
                child: Text("No lessons",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.grey,
                    )),
              );
          }
        },
      ),
    );
  }

  dialogTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.only(left: 15),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF43C000),
          ),
          child: Text(text),
        ),
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
            backgroundColor = const Color(0xFF58A700);
          } else if (lessonState.answerState == AnswerState.incorrect) {
            title = "GOT IT";
            backgroundColor = const Color(0xFFE53935);
          } else {
            title = "CHECK";
            backgroundColor = const Color(0xFF1F727E);
          }

          final isEnabled = lessonState.selectedAnswer != null;

          return ChicletAnimatedButton(
            width: MediaQuery.of(context).size.width - 40,
            backgroundColor: isEnabled 
                ? backgroundColor 
                : const Color(0xFFE5E7EB),
            onPressed: isEnabled
                ? () {
                    if (lessonState.answerState != AnswerState.readyForNext) {
                      final checkAnswer = lessonState.checkAnswer();
                      logger.w("Check Answer: $checkAnswer");
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
                color: isEnabled ? Colors.white : const Color(0xFF9CA3AF),
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

  static const _primaryColor = Color(0xFF1F727E);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.celebration_rounded,
                color: Color(0xFF16A34A),
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Level Complete!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Great job on finishing this level.",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 28),
            ChicletAnimatedButton(
              width: MediaQuery.of(context).size.width * 0.55,
              backgroundColor: _primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                "Back to Courses",
                style: TextStyle(
                  color: Color(0xFF6B7280),
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

  static const _primaryColor = Color(0xFF1F727E);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFFEF3C7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                color: Color(0xFFD97706),
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Course Complete!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "You've mastered all the lessons.",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 28),
            ChicletAnimatedButton(
              width: MediaQuery.of(context).size.width * 0.55,
              backgroundColor: _primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Practice Again",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                "Back to Courses",
                style: TextStyle(
                  color: Color(0xFF6B7280),
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
