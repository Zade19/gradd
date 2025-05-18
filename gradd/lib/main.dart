import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'database.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'main_page.dart';
import 'legal_page.dart';
import 'educational_page.dart';
import 'qrce_page.dart';
import 'preferences_page.dart';
import 'root_nav.dart';
import 'ui/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Back4app.initializeParse();
  //log out user on app startup
  final user = await ParseUser.currentUser();
  if (user != null) {
    await user.logout();
  }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth',
      home: SignInPage(),
      theme: buildAppTheme(),
      routes: {
        '/signup': (context) => SignUpPage(),
        '/home': (context) => MainNavigator(),
        '/home': (context) => const RootNav(),
      },
    );
  }
}
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 2;

  final List<Widget> _pages = [
    EducationalPage(),
    QRCEPage(),
    MainPage(),
    LegalPage(),
    PreferencesPage(),
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