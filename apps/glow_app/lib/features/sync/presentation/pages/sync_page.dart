import 'package:flutter/material.dart';

/// Sync status page.
class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync Status'),
      ),
      body: const Center(
        child: Text('Offline/Online Sync - TODO'),
      ),
    );
  }
}
