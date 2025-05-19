import 'package:flutter/material.dart';

class LawsRegulationsPage extends StatelessWidget {
  const LawsRegulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jordanian Business Laws')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _Heading('1. Company Formation'),
            _Paragraph(
              '• Primary statute: Companies Law No. 22 (1997) & amendments.\n'
                  '• Legal forms: Limited Liability Company (LLC), Private Shareholding, Public Shareholding, Sole Proprietorship.\n'
                  '• All entities register at the Ministry of Industry, Trade & Supply (MIT).',
            ),
            _Heading('2. Investment Incentives'),
            _Paragraph(
              '• Investment Environment Law No. 21 (2022) consolidates incentives.\n'
                  '• Key perks: customs exemptions on capital-goods, reduced income-tax for development-zone activities.',
            ),
            _Heading('3. Labour & Social Security'),
            _Paragraph(
              '• Labour Law No. 8 (1996 – latest amend. 2019): contracts, working hours (48 h/week), overtime, termination.\n'
                  '• Social Security Law No. 1 (2014): employers contribute 14.25 % of gross wage; employees 7.5 %.',
            ),
            _Heading('4. Tax Framework'),
            _Paragraph(
              '• Income Tax Law No. 38 (2018) – corporate rates 20 % (standard), 24 % (telecom/insurance), 35 % (banks).\n'
                  '• General Sales Tax Law No. 6 (1994) – standard GST 16 %; some goods 4 % or 0 %.',
            ),
            _Heading('5. IP & E-Commerce'),
            _Paragraph(
              '• Trademark Law No. 33 (1952), Patent Law No. 32 (1999).\n'
                  '• Electronic Transactions Law No. 15 (2015) recognises digital signatures & contracts.',
            ),
            _Heading('Key regulators & links'),
            _Paragraph(
              '• Companies Controller: https://www.ccd.gov.jo\n'
                  '• Jordan Investment Fund: https://www.jic.gov.jo\n'
                  '• Income & Sales Tax Dept: https://istd.gov.jo',
            ),
            SizedBox(height: 20),
            Text(
              'Always consult a qualified lawyer before acting; this summary is for awareness only.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String text;
  const _Heading(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 8),
    child: Text(text,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold)),
  );
}

class _Paragraph extends StatelessWidget {
  final String text;
  const _Paragraph(this.text);
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(context).textTheme.bodyLarge,
  );
}
