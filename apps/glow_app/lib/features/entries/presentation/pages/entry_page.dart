import 'package:flutter/material.dart';

/// Entry details page.
class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entry'),
      ),
      body: const Center(
        child: Text('Entry Details - TODO'),
      ),
    );
  }
}
