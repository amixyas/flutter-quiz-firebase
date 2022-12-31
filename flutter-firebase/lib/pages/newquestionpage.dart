import 'package:firebaseapp/model/quiz.dart';
import 'package:firebaseapp/pages/quizpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/questioncubit.dart';
import '../business_logic/blocmodel.dart';
import '../business_logic/quizcubit.dart';

class NewQuestionPage extends StatelessWidget {

  static const routeName = "NewQuiz";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => QuestionCubit(Quiz(question: "It's work fine", response: true))),
              BlocProvider(create: (_) => BlocModel(true)),
            ],
            child: Scaffold(
              body: MyCustomForm(),
            )
        )
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerQuestion = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: BlocBuilder<QuestionCubit, Quiz>(
            builder: (context, question) {
              return BlocBuilder<BlocModel, bool>(builder: (context, resp) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: 'Question',
                          hintText: 'Enter your question',
                          contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                        ),
                        controller: controllerQuestion,
                        validator: (value) {
                          if (value!.isEmpty == true) { return "The field is required"; }
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(child: ListTile(
                            title: const Text('True'),
                            leading: Radio<bool>(
                              value: true,
                              groupValue: resp,
                              onChanged: (bool? value) {
                                context.read<BlocModel>().add(TrueEvent());
                              },
                            ),
                          ),),
                          Expanded(child:  ListTile(
                            title: const Text('False'),
                            leading: Radio<bool>(
                              value: false,
                              groupValue: resp,
                              onChanged: (bool? value) {
                                context.read<BlocModel>().add(FalseEvent());
                              },
                            ),
                          ),),
                        ],
                      ),),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 14),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!.validate()) {
                                    Quiz question = Quiz(
                                        response: resp,
                                        question: controllerQuestion.text);
                                    context
                                        .read<QuestionCubit>()
                                        .addQuestion(question);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        context.read<QuizCubit>().saveQuiz());
                                  }
                                },
                                icon: Icon(
                                  Icons.publish,
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12))
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, QuizPage.routeName);
                                },
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 14),
                                  child: Text(
                                    "Home Page",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),

                                icon: Icon(
                                  Icons.arrow_back,
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12))
                                ),
                              ),],
                          )),
                    ),
                  ],
                );
              });
            })
    );
  }
}
