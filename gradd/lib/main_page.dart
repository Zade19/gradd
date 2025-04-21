import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome back, <name>!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('What can we interest you in?', style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[200], // Matching UI color
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: Text('QRCE Portal', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[200],
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: Text('Conduct a Feasibility Study', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
