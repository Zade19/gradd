import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaxCalculatorPage extends StatefulWidget {
  const TaxCalculatorPage({super.key});

  @override
  State<TaxCalculatorPage> createState() => _TaxCalculatorPageState();
}

class _TaxCalculatorPageState extends State<TaxCalculatorPage> {
  final _profitCtrl = TextEditingController();
  String _sector = 'Standard (20 %)';
  double? _taxDue;

  final _sectors = const {
    'Standard (20 %)': 0.20,
    'Telecom / Insurance (24 %)': 0.24,
    'Banks (35 %)': 0.35,
  };

  void _calculate() {
    final profit = double.tryParse(_profitCtrl.text.replaceAll(',', ''));
    if (profit == null) {
      setState(() => _taxDue = null);
      return;
    }
    final rate = _sectors[_sector]!;
    setState(() => _taxDue = profit * rate);
  }

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'en', symbol: 'JOD ');

    return Scaffold(
      appBar: AppBar(title: const Text('Jordan Tax Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _profitCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Annual net profit (JOD)',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _sector,
              decoration: const InputDecoration(labelText: 'Business sector'),
              items: _sectors.keys
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _sector = v!),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.calculate),
                label: const Text('Compute'),
                onPressed: _calculate,
              ),
            ),
            const SizedBox(height: 30),
            if (_taxDue != null)
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 30),
                  child: Column(
                    children: [
                      Text(
                        'Estimated CIT',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currency.format(_taxDue),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ),
            const Spacer(),
            Text(
              'For rough planning only — consult a tax adviser to confirm liabilities.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
