import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_6_2/quizz_app/bloc/quiz_bloc.dart';
import 'package:month_6_2/quizz_app/history_screen.dart';
import 'package:month_6_2/quizz_app/quiz_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final QuizBloc _quizBloc = QuizBloc();
  final TextEditingController _amountController = TextEditingController(
    text: '10',
  );

  @override
  void dispose() {
    _quizBloc.close();
    _amountController.dispose();
    super.dispose();
  }

  void _showAmountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Количество вопросов'),
          content: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Введите число вопросов',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _quizBloc.add(LoadQuizEvent());

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: _quizBloc,
                      child: const QuizScreen(),
                    ),
                  ),
                );
              },
              child: const Text('Начать'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => _showAmountDialog(context),
                child: const Text('Старт', style: TextStyle(fontSize: 50)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              },
              child: const Text('История', style: TextStyle(fontSize: 30)),
            ),
          ],
        ),
      ),
    );
  }
}
