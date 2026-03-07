// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:words625/application/level_provider.dart';
import 'package:words625/courses/languages/dictionary.dart';
import 'package:words625/di/injection.dart';
import 'package:words625/domain/course/course.dart';
import 'package:words625/views/lesson/lesson_screen.dart';

class ListLesson extends StatefulWidget {
  final Course course;
  final Question question;

  const ListLesson(this.question, {Key? key, required this.course})
      : super(key: key);

  @override
  State<ListLesson> createState() => _ListLessonState();
}

class _ListLessonState extends State<ListLesson> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setCourse(widget.course);
    });
  }

  setCourse(Course course) {
    final lessonProvider = context.read<LessonProvider>();
    lessonProvider.setCourse(course);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LessonProvider>(
      builder: (context, lessonProvider, child) {
        return Stack(
          children: [
            if (lessonProvider.answerState == AnswerState.correct ||
                lessonProvider.answerState == AnswerState.incorrect ||
                lessonProvider.answerState == AnswerState.readyForNext)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: lessonProvider.answerState.isCorrect
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFFFEBEE),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            lessonProvider.answerState.isCorrect
                                ? Icons.check_circle_rounded
                                : Icons.cancel_rounded,
                            color: lessonProvider.answerState.isCorrect
                                ? const Color(0xFF2E7D32)
                                : const Color(0xFFC62828),
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            lessonProvider.answerState.isCorrect
                                ? "Correct!"
                                : "Incorrect",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: lessonProvider.answerState.isCorrect
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFC62828),
                            ),
                          ),
                        ],
                      ),
                      if (lessonProvider.answerState.isIncorrect) ...[
                        const SizedBox(height: 12),
                        Text(
                          "Correct answer:",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${lessonProvider.currentQuestion?.correctAnswer}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xFFC62828),
                          ),
                        ),
                      ] else if (lessonProvider
                              .currentQuestion?.translatedSentence !=
                          null) ...[
                        const SizedBox(height: 12),
                        Text(
                          lessonProvider.currentQuestion?.translatedSentence ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF388E3C),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            Column(
              children: [
                Instruction(
                    prompt: lessonProvider.currentQuestion?.prompt ?? "--"),
                const Padding(padding: EdgeInsets.only(top: 15)),
                QuestionRow(question: lessonProvider.currentQuestion),
                const SizedBox(height: 8),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...lessonProvider.currentQuestion?.options?.map((option) {
                            final selectedAnswer =
                                lessonProvider.selectedAnswer;
                            return GestureDetector(
                              onTap: () {
                                lessonProvider.selectAnswer(option);
                              },
                              child: ListChoice(
                                title: option,
                                isSelected: selectedAnswer == option,
                                isCorrect: lessonProvider.isAnswerCorrect,
                              ),
                            );
                          }).toList() ??
                          [],
                    ],
                  ),
                ),
                const Spacer(),
                const CheckButton(),
              ],
            ),
          ],
        );
      },
    );
  }
}

class Instruction extends StatelessWidget {
  final String prompt;
  const Instruction({super.key, required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
        child: Text(
          prompt,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
            letterSpacing: -0.3,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}

class QuestionRow extends StatelessWidget {
  final Question? question;
  const QuestionRow({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpeakButton(sentence: question?.sentence ?? "--"),
          const SizedBox(width: 14),
          Flexible(
            child: question?.sentenceIsTargetLanguage ?? false
                ? RichText(
                    text: TextSpan(
                      children: _buildTextSpans(context),
                    ),
                  )
                : Text(
                    question?.sentence ?? "--",
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C2C2C),
                      height: 1.4,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildTextSpans(BuildContext context) {
    final words = question?.sentence?.split(' ') ?? [];

    return words.map((word) {
      return TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              enableFeedback: true,
              message: getWordMeaning(word),
              child: Text(
                word,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C2C2C),
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                  decorationColor: Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
          const TextSpan(
            text: ' ',
          ),
        ],
      );
    }).toList();
  }
}

class ListChoice extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isCorrect;

  const ListChoice({
    Key? key,
    required this.title,
    this.isSelected = false,
    this.isCorrect = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lessonState = context.watch<LessonProvider>();
    
    Color borderColor;
    Color backgroundColor;
    Color textColor = const Color(0xFF3C3C3C);
    
    if (lessonState.answerState.isCorrect && isSelected) {
      borderColor = const Color(0xFF58A700);
      backgroundColor = const Color(0xFFE8F5E9);
      textColor = const Color(0xFF2E7D32);
    } else if (lessonState.answerState == AnswerState.incorrect && isSelected) {
      borderColor = const Color(0xFFE53935);
      backgroundColor = const Color(0xFFFFEBEE);
      textColor = const Color(0xFFC62828);
    } else if (lessonState.answerState == AnswerState.selected && isSelected) {
      borderColor = const Color(0xFF1F727E);
      backgroundColor = const Color(0xFFF0FAFA);
      textColor = const Color(0xFF1F727E);
    } else {
      borderColor = const Color(0xFFE0E0E0);
      backgroundColor = Colors.white;
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: isSelected ? 2.0 : 1.5,
            color: borderColor,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: borderColor.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: textColor,
            letterSpacing: 0.1,
          ),
        ),
      ),
    );
  }
}

class SpeakButton extends StatelessWidget {
  final String sentence;
  const SpeakButton({super.key, required this.sentence});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1F727E),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => getIt<FlutterTts>().speak(sentence),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.volume_up_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
