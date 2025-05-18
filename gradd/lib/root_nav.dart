import 'package:flutter/material.dart';
import 'educational_page.dart';
import 'qrce_page.dart';
import 'main_page.dart';
import 'legal_page.dart';
import 'preferences_page.dart';

class RootNav extends StatefulWidget {
  const RootNav({super.key});

  @override
  State<RootNav> createState() => _RootNavState();
}

class _RootNavState extends State<RootNav> {
  int _current = 2;                                         // Home first

  final _screens = const [
    EducationalPage(),   // 0
    QRCEPage(),          // 1
    MainPage(),          // 2
    LegalPage(),         // 3
    PreferencesPage(),   // 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _current, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current,
        onTap: (i) => setState(() => _current = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book),        label: 'Materials'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance),  label: 'QRCE'),
          BottomNavigationBarItem(icon: Icon(Icons.home),             label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel),            label: 'Legal'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),         label: 'Prefs'),
        ],
      ),
    );
  }
}
