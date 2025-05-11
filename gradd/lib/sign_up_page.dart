import 'package:flutter/material.dart';
import 'package:gradd/sign_up_form_page.dart';
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

    // Basic validation
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Username is required.")));
      return;
    }
    if (firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("First name is required.")));
      return;
    }
    if (lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Last name is required.")));
      return;
    }
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email is required.")));
      return;
    }
    if (password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password is required.")));
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match!")));
      return;
    }

    final user = ParseUser(username, password, email)
      ..set('firstName', firstName)
      ..set('lastName', lastName)
      ..set('type', 'user');

    try {
      final response = await user.signUp();

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account created successfully!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpFormPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.error?.message}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
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
