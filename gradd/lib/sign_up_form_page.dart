import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignUpFormPage extends StatefulWidget {
  @override
  SignUpFormPageState createState() => SignUpFormPageState();
}

class SignUpFormPageState extends State<SignUpFormPage> {
  List<ParseObject> questions = [];
  int currentQuestionIndex = 0;
  bool loading = true;
  Map<String, dynamic> answers = {};

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final QueryBuilder<ParseObject> query =
    QueryBuilder<ParseObject>(ParseObject('questions'))
      ..whereEqualTo('formType', 'signup');

    final response = await query.query();

    if (response.success && response.results != null) {
      setState(() {
        questions = response.results as List<ParseObject>;
        loading = false;
      });
    } else {
      print('Error: ${response.error?.message}');
      setState(() {
        loading = false;
      });
    }
  }

  Widget buildQuestion(ParseObject question) {
    final text = question.get<String>('text') ?? 'Untitled question';
    final type = question.get<String>('type') ?? 'text';
    final key = question.objectId!;

    if (type == 'multiple') {
      final options = question.get<List<dynamic>>('options') ?? [];
      return DropdownButtonFormField(
        decoration: InputDecoration(labelText: text),
        items: options
            .map((opt) => DropdownMenuItem(value: opt, child: Text(opt.toString())))
            .toList(),
        value: answers[key],
        onChanged: (value) {
          setState(() {
            answers[key] = value;
          });
        },
      );
    } else {
      return TextField(
        decoration: InputDecoration(labelText: text),
        onChanged: (value) {
          answers[key] = value;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final visibleQuestions = questions.skip(currentQuestionIndex).take(3).toList();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Please answer a couple of questions about yourself:'),
            SizedBox(height: 20),
            ...visibleQuestions.map(buildQuestion).toList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (currentQuestionIndex + 3 < questions.length) {
                    currentQuestionIndex += 3;
                  } else {
                    // End of form - handle submission or next screen
                    print('All answers: $answers');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form completed!')),
                    );
                  }
                });
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

