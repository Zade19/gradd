import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class QuestionPage extends StatefulWidget {
  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {
  List<ParseObject> allQuestions = [];
  int currentIndex = 0;
  Map<String, dynamic> answers = {};
  Map<String, List<String>> questionOptions = {};

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final query = QueryBuilder<ParseObject>(ParseObject('question'))
      ..whereEqualTo('formType', 'login')
      ..orderByAscending('questionID');

    final response = await query.query();

    if (response.success && response.results != null) {
      final questions = response.results!.cast<ParseObject>();
      setState(() {
        allQuestions = questions;
      });

      // Fetch choices for each question
      for (var question in questions) {
        final questionId = question.objectId;
        if (questionId != null) {
          final optionsQuery = QueryBuilder<ParseObject>(ParseObject('choices'))
            ..whereEqualTo('questionID', ParseObject('question')..objectId = questionId);
          final optionsResponse = await optionsQuery.query();

          if (optionsResponse.success && optionsResponse.results != null) {
            final options = optionsResponse.results!
                .map((e) => e.get<String>('text') ?? '')
                .cast<String>()
                .toList();
            setState(() {
              questionOptions[questionId] = options;
            });
          }
        }
      }
    } else {
      print("Failed to load questions: \${response.error?.message}");
    }
  }

  List<ParseObject> getCurrentBatch() {
    int endIndex = (currentIndex + 3).clamp(0, allQuestions.length);
    return allQuestions.sublist(currentIndex, endIndex);
  }

  void nextBatch() {
    if (currentIndex + 3 < allQuestions.length) {
      setState(() {
        currentIndex += 3;
      });
    } else {
      print("Answers: \$answers");
    }
  }

  Widget buildQuestion(ParseObject question) {
    final type = question.get<String>('type');
    final questionId = question.objectId!;
    final text = question.get<String>('text') ?? '';

    if (type == 'multiple' && questionOptions.containsKey(questionId)) {
      final options = questionOptions[questionId]!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
          ...options.map((option) => RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: answers[questionId],
            onChanged: (value) {
              setState(() {
                answers[questionId] = value;
              });
            },
          ))
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            onChanged: (value) {
              answers[questionId] = value;
            },
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestions = getCurrentBatch();

    return Scaffold(
      appBar: AppBar(title: Text('Answer Questions')),
      body: allQuestions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ...currentQuestions.map(buildQuestion).toList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: nextBatch,
              child: Text(currentIndex + 3 < allQuestions.length ? 'Next' : 'Submit'),
            )
          ],
        ),
      ),
    );
  }
}