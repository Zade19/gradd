import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ResetPwPage extends StatefulWidget {
  const ResetPwPage({super.key});
  @override
  State<ResetPwPage> createState() => _ResetPwPageState();
}

class _ResetPwPageState extends State<ResetPwPage> {
  final _emailCtrl = TextEditingController();
  bool _busy = false;

  Future<void> _sendReset() async {
    final mail = _emailCtrl.text.trim();
    if (mail.isEmpty) {
      _snack('Enter an e-mail first');
      return;
    }
    setState(() => _busy = true);
    final res = await ParseUser(null, null, mail).requestPasswordReset();
    setState(() => _busy = false);

    if (res.success) {
      _snack('Reset link sent – check your inbox');
      Navigator.pop(context);
    } else {
      _snack(res.error?.message ?? 'Error');
    }
  }

  void _snack(String m) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Password recovery')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _emailCtrl,
            decoration: const InputDecoration(labelText: 'Account e-mail'),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Send reset link'),
              onPressed: _busy ? null : _sendReset,
            ),
          ),
        ],
      ),
    ),
  );
}
