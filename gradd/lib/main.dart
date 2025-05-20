import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'UI/theme.dart' show buildDarkTheme;
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
import 'core/theme_notifier.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Back4app.initializeParse();
  //log out user on app startup
  final user = await ParseUser.currentUser();
  if (user != null) {
    await user.logout();
  }
  //runApp(const MyApp());
  runApp(
      ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
           child: const MyApp(),
     ),
   );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeNotifier>().isDark;
    return MaterialApp(
      title: 'Flutter Auth',
      home: SignInPage(),
      theme: buildAppTheme(),
      routes: {
        '/signup': (context) => SignUpPage(),
        '/home': (context) => const RootNav(),
      },
    );
  }
}
