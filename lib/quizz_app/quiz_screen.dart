import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_6_2/quizz_app/bloc/quiz_bloc.dart';
import 'package:month_6_2/quizz_app/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int ind = 0;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is LoadedQuizState) {
              final currentQuiz = state.listQuiz[ind];

              final List<String> answers = [
                currentQuiz.correct_answer,
                ...currentQuiz.incorrect_answers,
              ]..shuffle();

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      currentQuiz.question,
                      style: const TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 24),
                      padding: const EdgeInsets.all(16),
                      itemCount: answers.length,
                      itemBuilder: (context, index) {
                        final isCorrect =
                            answers[index] == currentQuiz.correct_answer;
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              isCorrect ? Colors.green : Colors.red,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (isCorrect) {
                                score++;
                              }
                              ind++;
                            });

                            if (ind >= state.listQuiz.length) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                    score: score,
                                    total: state.listQuiz.length,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            answers[index],
                            style: const TextStyle(fontSize: 15),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            if (state is ErrorQuizState) {
              return const Center(
                child: Text(
                  "ERROR",
                  style: TextStyle(color: Colors.red, fontSize: 50),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          },
        ),
      ),
    );
  }
}