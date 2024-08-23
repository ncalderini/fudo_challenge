import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: const PostsList(),
    );
  }
}

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ListTile(
        title: Text("Post $index"),
        subtitle: Text("This is the post number $index"),
      ),
      separatorBuilder: (context, index) => const Divider(), 
      itemCount: 50
    );
  }
}