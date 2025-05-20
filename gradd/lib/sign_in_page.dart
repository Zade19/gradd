import 'package:flutter/material.dart';
import 'package:gradd/main_page.dart';
import 'package:gradd/form_page.dart';
import 'package:gradd/sign_up_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  bool rememberMe = false;
  bool forgotpassword = false;
  Future<void> _login() async {
    final userNameOrEmail = usernameController.text.trim();
    final password        = passwordController.text.trim();

    if (userNameOrEmail.isEmpty || password.isEmpty) {
      _snack('Please enter both fields');
      return;
    }


    String username = userNameOrEmail;
    if (userNameOrEmail.contains('@')) {
      final q = QueryBuilder<ParseUser>(ParseUser.forQuery())
        ..whereEqualTo('email', userNameOrEmail);
      final r = await q.query();
      if (r.success && r.results != null && r.results!.isNotEmpty) {
        username = (r.results!.first as ParseUser).username!;
      } else {
        _snack('No account found for that e-mail');
        return;
      }
    }

    final loginRes = await ParseUser(username, password, null).login();
    if (!loginRes.success) {
      _snack(loginRes.error?.message ?? 'Login failed');
      return;
    }

    // ✅  logged-in → now run the “answer” query just like before
    final signupQuery = QueryBuilder<ParseObject>(ParseObject('answer'))
      ..whereEqualTo('username', ParseObject('_User')..objectId = loginRes.result.objectId);

    final answerRes = await signupQuery.query();

    if (rememberMe) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('loggedInUsername', username);
      await storage.write(key: 'password', value: password);
    }

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
            Icon(Icons.account_circle, size: 100),
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
                Text('Forgot password?'),
                Checkbox(
                  value: forgotpassword,
                  onChanged: (bool? value) {
                    setState(() {
                      forgotpassword = value ?? false;
                    });
                  },
                ),
                Text('Remember me'),
              ],
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