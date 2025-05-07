import 'package:flutter/material.dart';
import 'package:gradd/main_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    _checkRememberedUser();
  }
  Future<void> _checkRememberedUser() async
  //function tests to see if there are login data saved and puts them in the text box
  {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('loggedInUsername');
    final savedPassword = prefs.getString('password');
    if (savedUsername != null && savedPassword!=null)
    {
      usernameController.text = savedUsername;
      passwordController.text = savedPassword;
    }
  }
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  Future<void> _login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    var login = QueryBuilder(ParseObject('user'))
    ..whereEqualTo('username', username)
    ..whereEqualTo('password', password);

    final response = await login.query();
    if (response.success && response.results!.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
      if (rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('loggedInUsername', username);
        await prefs.setString('password', password);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("incorrect login information")),
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
                Text('Remember me'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}