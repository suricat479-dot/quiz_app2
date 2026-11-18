import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz_history_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<QuizHistoryItem> historyList = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyString = prefs.getString('quiz_history');
    if (historyString != null) {
      setState(() {
        historyList = QuizHistoryItem.decode(historyString);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('История игр'),
          centerTitle: true,
        ),
        body: historyList.isEmpty
            ? const Center(
                child: Text(
                  'История игр пуста',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.separated(
                itemCount: historyList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final item = historyList[index];
                  return ListTile(
                    title: Text(
                      'Результат: ${item.score} / ${item.total}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('Дата: ${item.date}'),
                    trailing: Text(
                      '${item.percentage.toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}