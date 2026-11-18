import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:month_6_2/quizz_app/quiz_model.dart';
import 'package:month_6_2/quizz_app/repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState>{
  final Repository repository = Repository();
  QuizBloc() :super(QuizInitial()){
    on<LoadQuizEvent>((
      LoadQuizEvent event, Emitter<QuizState> emit,
    ) async{
      try{
        emit(LoadingQuizState());
        final List<QuizModel> listQuiz = await repository.GetQuizApi();
        emit(LoadedQuizState(listQuiz: listQuiz));
      }
      catch(e){
        emit(ErrorQuizState());
      }
    });
  }
}