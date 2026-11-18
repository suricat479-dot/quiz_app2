import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz_history_model.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
  });

  final int score;
  final int total;

  Future<void> _saveResult() async {
    final prefs = await SharedPreferences.getInstance();
    final double percentage = total > 0 ? (score / total) * 100 : 0.0;
    
    final newItem = QuizHistoryItem(
      score: score,
      total: total,
      percentage: percentage,
      date: "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}",
    );

    final String? historyString = prefs.getString('quiz_history');
    List<QuizHistoryItem> historyList = [];
    if (historyString != null) {
      historyList = QuizHistoryItem.decode(historyString);
    }
    
    historyList.insert(0, newItem);
    await prefs.setString('quiz_history', QuizHistoryItem.encode(historyList));
  }

  @override
  Widget build(BuildContext context) {
    _saveResult();
    final double percentage = total > 0 ? (score / total) * 100 : 0.0;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Результаты квиза',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Text(
                'Правильных ответов: $score из $total',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 12),
              Text(
                'Процент: ${percentage.toStringAsFixed(1)}%',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('На главную', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}