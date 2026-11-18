part of 'quiz_bloc.dart';

@immutable
sealed class QuizEvent {}

final class LoadQuizEvent extends QuizEvent {}