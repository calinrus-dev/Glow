import 'package:flutter/material.dart';

/// Permissions management page.
class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions'),
      ),
      body: const Center(
        child: Text('Permissions Management - TODO'),
      ),
    );
  }
}
