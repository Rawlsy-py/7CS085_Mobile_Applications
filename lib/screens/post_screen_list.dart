import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/main.dart';
import 'package:my_app/models/post.dart';
import 'package:my_app/screens/add_post_screen.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('7CS085 - Mobile App'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Post>('post').listenable(),
          builder: (context, Box<Post> box, _) {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (ctx, i) {
                final post = box.getAt(i);
                return Card(
                  child: ListTile(
                    title: Text(post!.title.toString()),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const AddPostScreen(),
              ),
            );
          },
          label: const Text('+ | Add Post')),
    );
  }
}
