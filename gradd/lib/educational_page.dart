import 'package:flutter/material.dart';
import 'what_you_need_page.dart';
import 'common_mistakes_page.dart';

class EducationalPage extends StatelessWidget {
  const EducationalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cardStyle = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Educational Material')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _InfoCard(
            title: 'What you need to know',
            icon: Icons.lightbulb_outline,
            color: Theme.of(context).colorScheme.primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WhatYouNeedPage()),
            ),
            shape: cardStyle,
          ),
          const SizedBox(height: 20),
          _InfoCard(
            title: 'Common mistakes to avoid',
            icon: Icons.report_problem_outlined,
            color: Colors.redAccent.shade200,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CommonMistakesPage()),
            ),
            shape: cardStyle,
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final GestureTapCallback onTap;
  final ShapeBorder shape;
  const _InfoCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.shape,
  });

  @override
  Widget build(BuildContext context) => Card(
    shape: shape,
    elevation: 4,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: SizedBox(
        height: 140,
        child: Center(
          child: ListTile(
            leading: Icon(icon, size: 48, color: color),
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    ),
  );
}
