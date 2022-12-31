import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseapp/pages/newquestionpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebaseapp/business_logic/quizbloc.dart';
import 'package:firebaseapp/business_logic/quizcubit.dart';
import 'package:firebaseapp/pages/quizpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => QuizCubit()),
    BlocProvider(create: (_) => QuizBloc()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

      return MaterialApp(
        title: 'Tp2',
        showSemanticsDebugger: false,
        builder: (context, child) {
          return Scaffold(
            body: child,
            appBar: AppBar(
              title: Text("Quiz"),
              backgroundColor: Colors.blue,
            ),
          );
        },
        home: QuizPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          NewQuestionPage.routeName: (context) => NewQuestionPage(),
          QuizPage.routeName: (context) => QuizPage()
        },
      );
  }
}

