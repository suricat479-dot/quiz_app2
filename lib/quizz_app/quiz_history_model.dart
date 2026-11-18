import 'dart:convert';

class QuizHistoryItem {
  final int score;
  final int total;
  final double percentage;
  final String date;

  QuizHistoryItem({
    required this.score,
    required this.total,
    required this.percentage,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'score': score,
        'total': total,
        'percentage': percentage,
        'date': date,
      };

  factory QuizHistoryItem.fromJson(Map<String, dynamic> json) => QuizHistoryItem(
        score: json['score'],
        total: json['total'],
        percentage: json['percentage'],
        date: json['date'],
      );

  static String encode(List<QuizHistoryItem> items) => json.encode(
        items.map((item) => item.toJson()).toList(),
      );

  static List<QuizHistoryItem> decode(String itemsStr) =>
      (json.decode(itemsStr) as List<dynamic>)
          .map<QuizHistoryItem>((item) => QuizHistoryItem.fromJson(item))
          .toList();
}