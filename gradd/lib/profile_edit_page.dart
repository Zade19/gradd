import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _username = TextEditingController();
  final _firstName = TextEditingController();
  final _middleName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  Future<void> _populateFields() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user == null) return;

    _username.text = user.username ?? '';
    _firstName.text = user.get<String>('firstName') ?? '';
    _middleName.text = user.get<String>('middleName') ?? '';
    _lastName.text = user.get<String>('lastName') ?? '';
    _email.text = user.emailAddress ?? '';

  }

  Future<void> _saveProfile() async {
    if (_isSaving) return;
    if (_password.text.isNotEmpty && _password.text != _confirmPassword.text) {
      _snack('Passwords do not match');
      return;
    }

    setState(() => _isSaving = true);

    final user = await ParseUser.currentUser() as ParseUser?;
    if (user == null) {
      _snack('Session expired. Please log in again.');
      return;
    }

    user..username = _username.text.trim()
      ..emailAddress = _email.text.trim()
      ..set('firstName', _firstName.text.trim())
      ..set('middleName', _middleName.text.trim())
      ..set('lastName', _lastName.text.trim());

    if (_password.text.isNotEmpty) {
      user.password = _password.text.trim();
    }

    final response = await user.save();
    setState(() => _isSaving = false);

    if (response.success) {
      _snack('Profile updated');
      Navigator.pop(context);
    } else {
      _snack(response.error?.message ?? 'Update failed');
    }
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _username.dispose();
    _firstName.dispose();
    _middleName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _input(_username, 'Username'),
            _spacer(),
            _input(_firstName, 'First Name'),
            _spacer(),
            _input(_middleName, 'Middle Name'),
            _spacer(),
            _input(_lastName, 'Last Name'),
            _spacer(),
            _input(_email, 'Email', keyboardType: TextInputType.emailAddress),
            _spacer(24),
            _input(_password, 'New Password', obscure: true),
            _spacer(),
            _input(_confirmPassword, 'Confirm Password', obscure: true),
            _spacer(32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveProfile,
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    : const Text('Save Changes', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(TextEditingController controller, String label,
      {bool obscure = false, TextInputType? keyboardType}) =>
      TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      );

  Widget _spacer([double height = 12]) => SizedBox(height: height);
}
