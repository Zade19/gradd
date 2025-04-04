import 'package:flutter/material.dart';

class LegalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Legal Assistant')),
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
              child: Text('Reading Material', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[200],
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: Text('Tax Calculator', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            Text('T3K', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}