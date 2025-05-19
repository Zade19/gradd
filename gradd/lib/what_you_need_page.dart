import 'package:flutter/material.dart';

class WhatYouNeedPage extends StatelessWidget {
  const WhatYouNeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('What you need to know')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _Heading('1. Validate the opportunity'),
            _Paragraph(
              '• Talk to at least 15–20 potential customers and confirm they '
                  'have the problem you think they have.\n'
                  '• Quantify the market size (top-down AND bottom-up).',
            ),
            _Heading('2. Craft a crisp value proposition'),
            _Paragraph(
              '• State the pain, the solution, the target user, and how '
                  'you are different—in one sentence.\n'
                  '• Iterate until a non-technical friend “gets it” in 30 seconds.',
            ),
            _Heading('3. Pick the right business model'),
            _Paragraph(
              '• Subscription, transaction fee, marketplace take-rate, or '
                  'one-time sale?\n'
                  '• Model out unit economics on a napkin before building anything.',
            ),
            _Heading('4. Understand the legal basics'),
            _Paragraph(
              '• Register the company, pick a share structure, and draft a '
                  'founders’ agreement early.\n'
                  '• Secure domain, trademarks, and any IP assignments.',
            ),
            _Heading('5. Plan your first 12 months of cash'),
            _Paragraph(
              '• Build a simple cash-flow spreadsheet: opening balance, '
                  'revenue, expenses, runway.\n'
                  '• Assume everything costs 30 % more and takes 30 % longer.',
            ),
            _Heading('6. Assemble a minimal core team'),
            _Paragraph(
              '• Founding team should cover product, distribution, and finance.\n'
                  '• Use freelancers for the rest until product-market fit.',
            ),
            _Heading('7. Design a go-to-market test'),
            _Paragraph(
              '• One narrow segment, one channel, one key metric.\n'
                  '• Goal: learn, not scale.',
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
