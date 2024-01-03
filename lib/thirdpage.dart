import 'package:flutter/material.dart';

class Question {
  final String prompt;
  final String option1;
  final String option2;
  final String option3;
  final String option4;

  Question(this.prompt, this.option1, this.option2, this.option3, this.option4);
}

class ThirdPage extends StatefulWidget {
  final List<Question> questions;

  ThirdPage({required this.questions});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  bool option1Selected = false;
  bool option2Selected = false;
  bool option3Selected = false;
  bool option4Selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        children: [
          // Display quiz questions and options
          for (var question in widget.questions)
            Column(
              children: [
                Text(question.prompt),
                CheckboxListTile(
                  title: Text(question.option1),
                  value: option1Selected,
                  onChanged: (value) {
                    setState(() {
                      option1Selected = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(question.option2),
                  value: option2Selected,
                  onChanged: (value) {
                    setState(() {
                      option2Selected = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(question.option3),
                  value: option3Selected,
                  onChanged: (value) {
                    setState(() {
                      option3Selected = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(question.option4),
                  value: option4Selected,
                  onChanged: (value) {
                    setState(() {
                      option4Selected = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
        ],
      ),
    );
  }
}