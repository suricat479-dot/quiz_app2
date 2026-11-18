import 'package:dio/dio.dart';
import 'package:month_6_2/quizz_app/quiz_model.dart';

final class Repository {
 // final Dio _dio = Dio();

Future <List <QuizModel>> GetQuizApi() async{
  final dio = Dio();
  final response = await dio.get('https://opentdb.com/api.php?amount=1');
  final data = response.data;
  final rowList = data['results'] as List;
  final list = rowList.map((e) => QuizModel.fromJson(e)).toList();
 return list;
}}