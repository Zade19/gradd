import 'package:flutter/material.dart';
import 'package:gradd/sign_in_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';
import '../core/theme_notifier.dart';
import 'profile_edit_page.dart';
import 'terms_page.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});
  Future<void> _logout(BuildContext context) async {
    final user = await ParseUser.currentUser();
    if (user != null) {
      await user.logout();
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SignInPage()),
          (route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();
    final isDark = themeNotifier.isDark;

    return Scaffold(
      appBar: AppBar(title: const Text('Preferences')),
      body: ListView(
        children: [
          const _SectionHeader('Account'),
          ListTile(
            leading: const Icon(Icons.person_outlined),
            title: const Text('Edit profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileEditPage()),
            ),
          ),
          const Divider(height: 0),

          const _SectionHeader('Legal'),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Terms & Conditions'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TermsPage()),
            ),
          ),

          const Divider(height: 0),

        ListTile(
        leading: const Icon(Icons.info_outline),
        title: const Text('App version'),
        subtitle: Text('1.0.0'),
        ),

          const Divider(height: 0),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
    child: Text(text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.bold)),
  );
}


