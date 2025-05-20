import 'package:flutter/material.dart';
import 'package:gradd/form_page.dart';
import 'package:gradd/sign_up_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gradd/reset_pw_page.dart';

final storage = FlutterSecureStorage();
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    checkRememberedUser();
  }
  bool rememberMe = false;
  Future<void> checkRememberedUser() async
  //function tests to see if there are login data saved and puts them in the text box
  {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('loggedInUsername');
    String? savedPassword = await storage.read(key: 'password');
    if (savedUsername != null && savedPassword!=null)
    {
      usernameController.text = savedUsername;
      passwordController.text = savedPassword;
    }
  }
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async
  {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    if (username.isEmpty || password.isEmpty) {
      _snack('Please enter both fields');
      return;
    }
    final loginResp = await ParseUser(username, password, null).login();
    if (!loginResp.success) {
      _snack(loginResp.error?.message ?? 'Login failed.');
      return;
    }
    final user = loginResp.result as ParseUser;


    if (rememberMe) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('loggedInUsername', username);
      await storage.write(key: 'password', value: password);
    }
    final answerQuery = QueryBuilder<ParseObject>(ParseObject('answer'))
      ..whereEqualTo('username', user)
      ..setLimit(1);
    final answerRes = await answerQuery.query();
    print(answerRes.success);
    print(answerRes.results);
    if (answerRes.success && answerRes.results != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => formPage(formType: 'signup')),
      );
    }
  }

  void _snack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 120,
            ),   // logo
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (bool? value) {
                    setState(() {
                      rememberMe = value ?? false;
                    });
                  },
                ),
                Text('Remember me'),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ResetPwPage()),
                ),
                child: const Text('Forgot password?'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              ),
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}