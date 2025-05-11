import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignUpFormPage extends StatefulWidget {
  @override
  _SignUpFormPageState createState() => _SignUpFormPageState();
}

class _SignUpFormPageState extends State<SignUpFormPage> {
  List<ParseObject> _questionsData = [];
  Map<int, List<String>> questionChoices = {};
  final Map<int, String> _answers = {};
  int _currentPage = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions();

  }

  Future<void> fetchQuestions() async {
    final QueryBuilder<ParseObject> questionQuery =
    QueryBuilder<ParseObject>(ParseObject('question'))
      ..whereEqualTo('formType', 'signup');

    final questionResponse = await questionQuery.query();

    if (questionResponse.success && questionResponse.results != null) {
      setState(() {
        _questionsData = questionResponse.results as List<ParseObject>;
        _isLoading = false;
      });

    }
    }

    for(int i=0;i<questionResponse.results!.length;i++)
    {
      QueryBuilder<ParseObject> choiceQuery =
      QueryBuilder<ParseObject>(ParseObject('questions_choice'))
        ..whereEqualTo('questionID', _questionsData[i].objectId);
      var choiceResponse = await choiceQuery.query();
      if (choiceResponse.success && choiceResponse.results != null)
      {
        var choices = choiceResponse.results as List<ParseObject>;
        for(int j=0; j<choiceResponse.count;j++)
        {
            questionChoices[i]!.add(
                choices[j].get<String>('text') ?? '');
        }
      }
    }
  }

  List<ParseObject> get _currentQuestions {
    final start = _currentPage * 3;
    final end = (_currentPage + 1) * 3;
    return _questionsData.sublist(
      start,
      end > _questionsData.length ? _questionsData.length : end,
    );
  }

  void _goNext() {
    if ((_currentPage + 1) * 3 < _questionsData.length) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _goBack() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
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
                  final isFill = questionType == 'fillInTheBlank';
                  final options = q.get<List<dynamic>>('options') ?? [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      isFill
                          ? TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your answer',
                        ),
                        controller: TextEditingController(
                          text: _answers[questionNumber] ?? '',
                        ),
                        onChanged: (val) {
                          _answers[questionNumber] = val;
                        },
                      )
                          : DropdownButton<String>(
                        isExpanded: true,
                        value: _answers[questionNumber],
                        hint: Text('Select an option'),
                        items: options.map((opt) {
                          return DropdownMenuItem<String>(
                            value: opt.toString(),
                            child: Text(opt.toString()),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _answers[questionNumber] = val!;
                          });
                        },
                      ),
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
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

