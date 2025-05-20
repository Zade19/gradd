import 'package:flutter/material.dart';
import 'package:gradd/services/firebase_messaging.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'qrce_page.dart';
import 'tax_calculator_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String username = '';

  @override
  void initState() {
    super.initState();                 // call parent first
    requestNotificationPermission();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (!mounted) return;
    setState(() => username = user?.username ?? 'Guest');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homepage')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome back, $username!',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'What can we interest you in?',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // ── QRCE button ─────────────────────────────────────────────
            _bigButton(
              context,
              label: 'QRCE Portal',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QRCEPage()),
              ),
            ),

            const SizedBox(height: 24),

            // ── Tax button ──────────────────────────────────────────────
            _bigButton(
              context,
              label: 'Tax Calculator',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TaxCalculatorPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// helper to keep buttons consistent
  Widget _bigButton(BuildContext context,
      {required String label, required VoidCallback onTap}) =>
      SizedBox(
        width: double.infinity,
        height: 70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[300],
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
          ),
          onPressed: onTap,
          child: Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      );
}
