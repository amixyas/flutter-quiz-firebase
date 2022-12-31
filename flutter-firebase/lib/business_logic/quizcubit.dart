import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebaseapp/business_logic/quizbloc.dart';
import 'package:firebaseapp/model/quiz.dart';

class QuizPageInitial  {
  int index = 0;
  List<Quiz> question = [];

  QuizPageInitial(this.index, this.question);

}

class QuizCubit extends Cubit<QuizPageInitial> {
  int questionIndex = 0;
  bool? responseStatus;
  List<Quiz> question = [];

  QuizCubit() : super(QuizPageInitial(0, []));

  nextQuestion() {
    ++questionIndex;
    emit(QuizPageInitial(questionIndex,question));
  }


  getNewQuestion()async {
    var list = await QuizBloc.getQuestions();
    question = list;
    emit(QuizPageInitial(questionIndex,question));
  }


  reset() {
    questionIndex = 0;
    emit(QuizPageInitial(questionIndex,question));
  }


  SnackBar correctAnswer(){
    var snackMessage = "Correct answer :)";
    return SnackBar(
        content: Text(snackMessage), backgroundColor: Colors.green
    );
  }


  SnackBar wrongAnswer(){
    var snackMessage = "Wrong answer :(";
    return SnackBar(
        content: Text(snackMessage), backgroundColor: Colors.red
    );
  }

  SnackBar saveQuiz(){
    var snackMessage = "Question saved successfully";
    return SnackBar(
        content: Text(snackMessage), backgroundColor: Colors.green
    );
  }

  bool checkResponse(bool response, List<Quiz> questions,int index) {
    if (questions.isNotEmpty) {
      if (response == questions.elementAt(questionIndex).response) {

        responseStatus = true;
        if(index+1<questions.length) {
          nextQuestion();
        }
        else {
          reset();
        }
        return true;
      } else {
        responseStatus = false;
        return false;
      }
    } else{
      return false;
    }
  }


}
