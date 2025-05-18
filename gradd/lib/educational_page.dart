import 'package:flutter/material.dart';

class EducationalPage extends StatelessWidget {
  const EducationalPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Educational content')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[200],
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: Text('What you need to know', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[200],
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: Text('Common mistakes to avoid', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}