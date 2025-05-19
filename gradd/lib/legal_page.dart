import 'package:flutter/material.dart';
import 'laws_regulations_page.dart';
import 'tax_calculator_page.dart';

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Legal Assistant')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _InfoCard(
            title: 'Laws & Regulations (Jordan)',
            icon: Icons.library_books_outlined,
            color: Colors.teal.shade400,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LawsRegulationsPage()),
            ),
            shape: cardShape,
          ),
          const SizedBox(height: 20),
          _InfoCard(
            title: 'Jordan Tax Calculator',
            icon: Icons.calculate_outlined,
            color: Colors.orange.shade600,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TaxCalculatorPage()),
            ),
            shape: cardShape,
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
