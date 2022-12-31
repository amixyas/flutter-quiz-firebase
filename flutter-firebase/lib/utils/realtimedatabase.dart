import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseapp/model/quiz.dart';

class RealtimeDataBase {
  static late DatabaseReference db;

  RealtimeDataBase() {
    db = FirebaseDatabase.instance.reference();
  }

  addQuestion(Quiz question) async {
    return await db
        .child('questions')
        .push()
        .set(question.toJson())
        .then((result) async {
    }).catchError((onError) {
      print(onError.toString());
    }).whenComplete(() => {});
  }

  static Future<DataSnapshot> getQuestion() async {
    return await db.child('questions').once();
  }


}
