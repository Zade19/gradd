import 'package:flutter/material.dart';
import 'package:gradd/form_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
class QRCEPage extends StatelessWidget {
  const QRCEPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QRCE Portal')),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            minimumSize: const Size(200, 50),              // width, height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => formPage(formType: 'QRCE'),
              ),
            );
          },
          child: const Text(
            'Open QRCE Form',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
