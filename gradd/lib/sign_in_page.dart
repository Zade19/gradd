import 'package:flutter/material.dart';
import 'package:gradd/main_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    var login = QueryBuilder(ParseObject('user'))
    ..whereEqualTo('username', username)
    ..whereEqualTo('password', password);

    final response = await login.query();
    if (response.success && response.results!.isNotEmpty) {
      print('Login successful!');
      // Navigator.pushNamed(context, '/mainpage');
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
      //todo:add the code to go  to nextpage if login is successful here
    } else {
      print('Login failed!');
      //todo:add the code for the fail whatever it is here
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