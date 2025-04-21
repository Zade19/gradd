import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
  }
class SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  Future<void> signup() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();



    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required.")),
      );
      return;
    }//todo:make it so it shows a message for each field

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match!")),
      );//todo: make a different method to notify the user
      return;
    }

    final user = ParseObject('user')
      ..set('username', username)
      ..set('email', email)
      ..set('password', password)
      ..set('type', 'user')
      ..set('firstName', firstName)
      ..set('lastName', lastName);

    try {
      final response = await user.save();
      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account created successfully!")),
        );
        Navigator.pushNamed(context, '/signupform');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.error!.message}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
      //todo:pick a way to display the message
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username')),
            SizedBox(height: 10),
            TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First name')),
            SizedBox(height: 10),
            TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last name')),
            SizedBox(height: 10),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 10),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true),
            SizedBox(height: 10),
            TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signup,
              child: Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
