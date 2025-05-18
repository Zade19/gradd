import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  Future<String> _loadTerms() async =>
      await rootBundle.loadString('assets/legal/terms.txt');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: FutureBuilder<String>(
        future: _loadTerms(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Text(snap.data!, style: Theme.of(context).textTheme.bodyLarge),
          );
        },
      ),
    );
  }
}
