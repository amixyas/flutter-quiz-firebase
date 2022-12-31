import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebaseapp/business_logic/quizbloc.dart';
import 'package:firebaseapp/business_logic/quizcubit.dart';
import 'package:firebaseapp/model/quiz.dart';

import 'newquestionpage.dart';

class QuizPage extends StatefulWidget {
  static const routeName = "QuizPage";

  QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Quiz> questions = [];
  QuizBloc q = QuizBloc();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quiz>>(
      future: QuizBloc.getQuestions(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<List<Quiz>> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Loading Data'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            questions = snapshot.data!;
            return Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: BlocBuilder<QuizCubit, QuizPageInitial>(

                    builder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Container(
                                height: 149,
                                width: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  /*
                                  child: Image.network(
                                    questions.elementAt(index.index).image,
                                    fit: BoxFit.cover,
                                  ),
                                  */
                                  child : Image.asset('assets/flutter.png'),
                                )
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
                              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                              height: 80,
                              width: 280,
                              child: Text(
                                questions.isNotEmpty ? questions.elementAt(index.index).question : "",
                                style: TextStyle(color: Colors.black, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 4,
                            width: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    var res =   context.read<QuizCubit>().checkResponse(true, questions,index.index);
                                    if (res) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          context.read<QuizCubit>().correctAnswer());
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          context.read<QuizCubit>().wrongAnswer());
                                    }
                                  },
                                  icon: Icon(
                                    Icons.check,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    child: Text(
                                      "True",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12)
                                      )
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    var res =  context.read<QuizCubit>().checkResponse(false, questions,index.index);
                                    if (res) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          context
                                              .read<QuizCubit>()
                                              .correctAnswer());
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          context.read<QuizCubit>().wrongAnswer());
                                    }
                                  },
                                  icon: Icon(
                                    Icons.cancel_sharp,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    child: Text(
                                      "False",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12))
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if(index.index+1<questions.length) { context.read<QuizCubit>().nextQuestion();}else
                                    {
                                      context.read<QuizCubit>().reset();
                                    }
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                      child: Icon(Icons.arrow_forward)),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12))),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, NewQuestionPage.routeName);
                                  },
                                  icon: Icon(
                                    Icons.new_releases,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 14),
                                    child: Text(
                                      "New Quiz",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12))
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }));
          } // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
