
final class QuizModel {
  final String type;
  final String difficulty;
  final String category;
  final String question;
  final String correct_answer;
  final List<String> incorrect_answers;

  QuizModel({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correct_answer,
    required this.incorrect_answers,
  });


factory QuizModel.fromJson(Map<String, dynamic> json) {
  return QuizModel(
    type:json['type'], 
    difficulty: json['difficulty'], 
    category: json['category'], 
    question: json['question'], 
    correct_answer: json['correct_answer'], 
    incorrect_answers: json['incorrect_answers']);
} }