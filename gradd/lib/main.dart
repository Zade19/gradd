import 'package:flutter/material.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'sign_up_form_page.dart';
import 'main_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: SignInPage(),
      routes: {
        '/signup': (context) => SignUpPage(),
        '/signupform': (context) => SignUpFormPage(),
        '/mainpage': (context) => MainPage(),
      },
    );
  }
}