// lib/pages/profile_edit_page.dart
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _username = TextEditingController();
  final _first    = TextEditingController();
  final _last     = TextEditingController();
  final _email    = TextEditingController();
  final _pw       = TextEditingController();
  final _pw2      = TextEditingController();

  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final u = await ParseUser.currentUser() as ParseUser?;
    if (u == null) return;
    setState(() {
      _username.text = u.username ?? '';
      _first.text    = u.get<String>('firstName') ?? '';
      _last.text     = u.get<String>('lastName') ?? '';
      _email.text    = u.emailAddress ?? '';
    });
  }

  Future<void> _save() async {
    if (_busy) return;

    // basic checks — same as in Sign-Up
    if (_username.text.trim().isEmpty ||
        _first.text.trim().isEmpty    ||
        _last.text.trim().isEmpty     ||
        _email.text.trim().isEmpty) {
      _snack('All fields except password are required');
      return;
    }
    if (_pw.text.isNotEmpty && _pw.text != _pw2.text) {
      _snack('Passwords do not match');
      return;
    }

    setState(() => _busy = true);
    final u = await ParseUser.currentUser() as ParseUser?;

    if (u == null) {
      _snack('Session expired — please log in again');
      return;
    }

    u.username        = _username.text.trim();
    u.emailAddress    = _email.text.trim();
    u.set('firstName', _first.text.trim());
    u.set('lastName',  _last.text.trim());
    if (_pw.text.isNotEmpty) u.password = _pw.text.trim();

    final res = await u.save();
    setState(() => _busy = false);

    if (res.success) {
      _snack('Profile updated');
      Navigator.pop(context);                       // back to Preferences
    } else {
      _snack(res.error?.message ?? 'Update failed');
    }
  }

  void _snack(String m) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  void dispose() {
    _username.dispose();
    _first.dispose();
    _last.dispose();
    _email.dispose();
    _pw.dispose();
    _pw2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _field(_username, 'Username'),
            _gap(),
            _field(_first, 'First name'),
            _gap(),
            _field(_last, 'Last name'),
            _gap(),
            _field(_email, 'Email', keyboard: TextInputType.emailAddress),
            _gap(24),
            _field(_pw,  'New password',   obscure: true),
            _gap(),
            _field(_pw2, 'Confirm password', obscure: true),
            _gap(32),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _busy ? null : _save,
                child: _busy
                    ? const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2)
                    : const Text('Save changes', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label,
      {bool obscure = false, TextInputType? keyboard}) =>
      TextField(
        controller: c,
        obscureText: obscure,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      );

  Widget _gap([double h = 10]) => SizedBox(height: h);
}
