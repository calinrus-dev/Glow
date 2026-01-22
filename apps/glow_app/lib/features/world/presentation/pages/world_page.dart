import 'package:flutter/material.dart';

/// World page - main social feed.
class WorldPage extends StatelessWidget {
  const WorldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World'),
      ),
      body: const Center(
        child: Text('World Feed - TODO'),
      ),
    );
  }
}
