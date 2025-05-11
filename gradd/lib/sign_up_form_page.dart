import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'main_page.dart';

class SignUpFormPage extends StatefulWidget {
  @override
  _SignUpFormPageState createState() => _SignUpFormPageState();
}

class _SignUpFormPageState extends State<SignUpFormPage> {
  List<ParseObject> _questionsData = [];
  Map<int, List<String>> questionChoices = {};
  final Map<int, String> _answers = {};
  final Map<int, File?> _images = {};
  int _currentPage = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final questionQuery =
    QueryBuilder<ParseObject>(ParseObject('question'))..whereEqualTo('formType', 'signup');

    final questionResponse = await questionQuery.query();

    if (questionResponse.success && questionResponse.results != null) {
      _questionsData = questionResponse.results as List<ParseObject>;

      for (int i = 0; i < _questionsData.length; i++) {
        final questionId = _questionsData[i].objectId;
        final choiceQuery = QueryBuilder<ParseObject>(ParseObject('questions_choice'))
          ..whereEqualTo('questionID', ParseObject('question')..objectId = questionId);

        final choiceResponse = await choiceQuery.query();

        if (choiceResponse.success && choiceResponse.results != null) {
          final choices = choiceResponse.results as List<ParseObject>;
          questionChoices[i] = choices.map((c) => c.get<String>('text') ?? '').toList();
        }
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      print('Error fetching questions: ${questionResponse.error?.message}');
      setState(() => _isLoading = false);
    }
  }

  List<ParseObject> get _currentQuestions {
    final start = _currentPage * 3;
    final end = (_currentPage + 1) * 3;
    return _questionsData.sublist(start, end > _questionsData.length ? _questionsData.length : end);
  }

  Widget buildQuestionField(String questionType, int questionNumber) {
    switch (questionType) {


      case 'multipleChoice':
        final options = questionChoices[questionNumber] ?? [];
        return DropdownButton<String>(
          isExpanded: true,
          value: _answers[questionNumber],
          hint: Text('Select an option'),
          items: options.map((opt) => DropdownMenuItem(value: opt, child: Text(opt))).toList(),
          onChanged: (val) => setState(() => _answers[questionNumber] = val!),
        );

      case 'date':
        return InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() {
                _answers[questionNumber] = picked.toIso8601String();
              });
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Select a date',
            ),
            child: Text(
              _answers[questionNumber]?.split('T').first ?? 'Tap to pick date',
            ),
          ),
        );

      case 'image':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              child: Text(_images[questionNumber] != null ? 'Change Image' : 'Upload Image'),
              onPressed: () async {
                final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  setState(() {
                    _images[questionNumber] = File(picked.path);
                    _answers[questionNumber] = picked.path;
                  });
                }
              },
            ),
            if (_images[questionNumber] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Image.file(_images[questionNumber]!, height: 100),
              ),
          ],
        );

      default:
        return TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your answer',
          ),
          controller: TextEditingController(text: _answers[questionNumber] ?? ''),
          onChanged: (val) => _answers[questionNumber] = val,
        );
    }
  }

  void _goNext() {
    if ((_currentPage + 1) * 3 < _questionsData.length) {
      setState(() => _currentPage++);
    }
  }

  void _goBack() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    }
  }
   _submit() async {
    final user = await ParseUser.currentUser() as ParseUser;
    for(int i = 0; i < _questionsData.length; i++) {
      if (_questionsData[i].get<String>('questionType') == 'image') {
        final file = _images[i];
        if (file != null) {
          final parseFile = ParseFile(file);
          final fileResponse = await parseFile.save();
          if (fileResponse.success) {
            _answers[i]= parseFile.url!;
          } else {
            continue;
          }
        }
      }
      final answerObject = ParseObject('answer')
        ..set('questionID', ParseObject('question')..objectId = _questionsData[i].objectId)
        ..set('username', user)
        ..set('answer', _answers[i]);
      final response = await answerObject.save();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    final totalPages = (_questionsData.length / 3).ceil();
    final progress = (_currentPage + 1) / totalPages;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Questionnaire'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                minHeight: 8,
                value: _questionsData.isEmpty ? 0 : progress,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: _currentQuestions.length,
                separatorBuilder: (_, __) => SizedBox(height: 24),
                itemBuilder: (context, index) {
                  final questionNumber = _currentPage * 3 + index;
                  final q = _currentQuestions[index];
                  final questionType = q.get<String>('questionType') ?? '';
                  final text = q.get<String>('text') ?? '';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      SizedBox(height: 8),
                      buildQuestionField(questionType, questionNumber),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentPage > 0 ? _goBack : null,
                  icon: Icon(Icons.arrow_back),
                  label: Text('Back'),
                ),
                ElevatedButton.icon(
                  onPressed: (_currentPage + 1) * 3 < _questionsData.length ? _goNext : null,
                  icon: Icon(Icons.arrow_forward),
                  label: Text('Next'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('Submit'),
                )

              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}


