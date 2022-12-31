import 'package:firebaseapp/model/quiz.dart';
import 'package:firebaseapp/utils/realtimedatabase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionCubit extends Cubit<Quiz> {
  late RealtimeDataBase realtimeDataBase;

  QuestionCubit(Quiz initialState) : super(initialState) {
    realtimeDataBase = RealtimeDataBase();
  }

  addQuestion(Quiz question) async {
    print("Add question called");
    await realtimeDataBase.addQuestion(question);
    emit(question);
  }
}
