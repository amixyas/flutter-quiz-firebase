import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebaseapp/model/quiz.dart';
import 'package:firebaseapp/utils/realtimedatabase.dart';

import '../model/quiz.dart';

class QuizBloc extends Bloc {
  late RealtimeDataBase realtimeDataBase;
  static List<Quiz> questions = [];

  QuizBloc() : super(null) {
    realtimeDataBase = RealtimeDataBase();
  }

 static Future<List<Quiz>> getQuestions() async {
    await RealtimeDataBase.getQuestion().then((result) async {
      Map<dynamic, dynamic> resp = result.value;
      print(result.value);
      questions = resp.entries
          .map((quest) => Quiz(
              response: quest.value["response"],
              question: quest.value["question"],
              //imgUrl: quest.value["imgUrl"],
      )).toList();
    }).catchError((onError) {
      print(onError.toString());
    }).whenComplete(() => {});
    return Future.value(questions);
  }
}
