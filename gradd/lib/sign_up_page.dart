import 'package:flutter/material.dart';
import 'package:gradd/form_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
  }
class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
  Future<void> signup() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final firstName = _firstNameController.text.trim();
    final middleName = _middleNameController.text.trim();
    final lastName = _lastNameController.text.trim();

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
      ..set('middleName', middleName)
      ..set('lastName', lastName)
      ..set('type', 'user');

    try {
      final response = await user.signUp();

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account created successfully!")),
        );
        final user = ParseUser(username, password, null);
        final response = await user.login();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => formPage(formType: 'signup')),
        );;

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
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username')),
            SizedBox(height: 10),
            TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First name')),
            SizedBox(height: 10),
            TextField(
                controller: _middleNameController,
                decoration: InputDecoration(labelText: 'Middle name')),
            SizedBox(height: 10),
            TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last name')),
            SizedBox(height: 10),
            TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 10),
            TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true),
            SizedBox(height: 10),
            TextField(
                controller: _confirmPasswordController,
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
