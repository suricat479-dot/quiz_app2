part of 'quiz_bloc.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class LoadingQuizState extends QuizState {}

final class ErrorQuizState extends QuizState {}

final class LoadedQuizState extends QuizState {
  final List<QuizModel> listQuiz;
  LoadedQuizState({required this.listQuiz});
}