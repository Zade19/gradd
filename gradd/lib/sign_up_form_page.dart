import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignUpFormPage extends StatefulWidget {
  @override
  SignUpFormPageState createState() => SignUpFormPageState();
}
Future<void> fetchQuestions() async{

}
class SignUpFormPageState extends State<SignUpFormPage> {
  List<ParseObject> questions = [];
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please answer a couple of questions about yourself:'),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: 'Question 1')),
            SizedBox(height: 10),
            DropdownButtonFormField(
              items: ['Option 1', 'Option 2']
                  .map((option) => DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
              onChanged: (value) {},
              decoration: InputDecoration(labelText: 'Question 2'),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              items: ['Option A', 'Option B']
                  .map((option) => DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
              onChanged: (value) {},
              decoration: InputDecoration(labelText: 'Question 3'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text('Next')),
          ],
        ),
      ),
    );
  }
}
