import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'sign_up_form_page.dart';
import 'main_page.dart';
import 'legal_page.dart';
import 'material_page.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Back4app.initializeParse();
  runApp(MyApp());
}
void registerNotifications() async{
//  FirebaseMessaging messaging = messaging.instance;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/signupform': (context) => QuestionPage(),
        '/mainpage': (context) => MainPage(),
      },
    );
  }
}
class MainNavigator extends StatefulWidget {
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 2;

  final List<Widget> _pages = [
    MainPage(),
    LegalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue, // Customize as needed
        unselectedItemColor: Colors.grey, // Customize as needed
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Materials',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'QRCE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            label: 'Legal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Preferences',
          ),
        ],
      ),
    );
  }
}