import 'package:flutter/material.dart';

/// Environment details page.
class EnvironmentPage extends StatelessWidget {
  const EnvironmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Environment'),
      ),
      body: const Center(
        child: Text('Environment Details - TODO'),
      ),
    );
  }
}
