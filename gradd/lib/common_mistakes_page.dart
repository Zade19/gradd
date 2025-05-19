import 'package:flutter/material.dart';

class CommonMistakesPage extends StatelessWidget {
  const CommonMistakesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Common mistakes to avoid')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _Mistake(
              title: 'Building before validating',
              fix:
              'Run customer interviews and landing-page tests first. Code '
                  'is the most expensive way to test an idea.',
            ),
            _Mistake(
              title: 'Trying to serve everyone',
              fix:
              'Start with a beach-head niche where you can be **best in the world** '
                  'for a specific persona.',
            ),
            _Mistake(
              title: 'Ignoring unit economics',
              fix:
              'If each sale costs \$10 in ads and earns \$6 in margin, no amount of “scale” fixes it.',
            ),
            _Mistake(
              title: 'Hiring too fast',
              fix:
              'Headcount is the largest fixed cost. Validate revenue **then** hire.',
            ),
            _Mistake(
              title: 'Under-pricing',
              fix:
              'Cheap prices don’t create demand; they just kill margins. '
                  'Charge based on value, not cost.',
            ),
            _Mistake(
              title: 'Neglecting legal paperwork',
              fix:
              'Get NDAs, IP assignment, and founders’ agreement in place before money flows.',
            ),
            _Mistake(
              title: 'Feature bloat',
              fix:
              'Ship the smallest feature set that solves one painful use-case; '
                  'iterate with real feedback.',
            ),
          ],
        ),
      ),
    );
  }
}

class _Mistake extends StatelessWidget {
  final String title;
  final String fix;
  const _Mistake({required this.title, required this.fix});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(fix, style: Theme.of(context).textTheme.bodyLarge),
      ],
    ),
  );
}
