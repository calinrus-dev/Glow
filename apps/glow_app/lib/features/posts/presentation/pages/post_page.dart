import 'package:flutter/material.dart';

/// Post details page.
class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: const Center(
        child: Text('Post Details - TODO'),
      ),
    );
  }
}
