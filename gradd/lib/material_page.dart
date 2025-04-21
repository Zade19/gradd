import 'package:flutter/material.dart';

class MaterialPage extends StatelessWidget {
  const MaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      appBar: AppBar(title: Text('Reading Material')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Loading', style: TextStyle(fontSize: 22)),
            SizedBox(height: 30),
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
              child: Text('Regulations', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}