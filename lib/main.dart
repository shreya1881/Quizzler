import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

Quizbrain quizbrain = Quizbrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  void checkAnswer(bool userPickedAnswer) {
    bool CorrectAnswer = quizbrain.getQuestionAnswer();
    setState(() {
      if (quizbrain.isfinished() == true) {
        Alert(
                context: context,
                title: "Finished",
                desc: "You have reached the end of the quiz")
            .show();
        quizbrain.reset();
        scoreKeeper = [];
      } else {
        if (CorrectAnswer == userPickedAnswer) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizbrain.check();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbrain.getQuestionText(),
                style: TextStyle(color: Colors.white, fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Expanded(
            child: SizedBox(
              height: 80.0,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  'True',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () {
                  checkAnswer(true);
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Expanded(
            child: SizedBox(
              height: 80.0,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  'False',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () {
                  checkAnswer(false);
                },
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
