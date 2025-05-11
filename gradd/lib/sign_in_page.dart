import 'package:flutter/material.dart';
import 'package:gradd/main_page.dart';
import 'package:gradd/sign_up_form_page.dart';
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
  Future<void> _login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both username and password")),
      );
      return;
    }

    final user = ParseUser(username, password, null);

    // Attempt to login with ParseUser
    final response = await user.login();

    if (response.success) {


      // Remember the user if they want to stay logged in
      if (rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('loggedInUsername', username);
        await storage.write(key: 'password', value: password);
      }
      final signupQuery = QueryBuilder<ParseObject>(ParseObject('answer'))
        ..whereEqualTo('username', ParseObject('_User')..objectId = user.objectId);
      final response = await signupQuery.query();
      // Navigate to MainPage
      print(response.results);
      if(response.success&&response.results!=null)
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpFormPage()),
        );
      }
    } else {
      // Show an error message if login failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incorrect login information")),
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
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpFormPage()),
              ),
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}