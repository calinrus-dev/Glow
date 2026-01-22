import 'package:flutter/material.dart';

/// User identity/profile page.
class IdentityPage extends StatelessWidget {
  const IdentityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('User Profile - TODO'),
      ),
    );
  }
}
