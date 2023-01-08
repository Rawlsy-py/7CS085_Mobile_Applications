import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/models/post.dart';
import 'package:my_app/screens/add_post_screen.dart';
import 'package:my_app/screens/view_post_screen.dart';

import 'edit_post_screen.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // To refresh the list, you can simply call setState()
              setState(() {});
            },
          ),
        ],
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: Hive.box<Post>('post').listenable(),
        builder: (context, Box<Post> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (ctx, i) {
              final post = box.getAt(i);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((ctx) => ViewPostScreen(
                                title: post.title,
                                description: post.description,
                                imageUrl: post.imageUrl)),
                          ),
                        );
                      },
                      leading: Image.file(
                        File(
                          post!.imageUrl.toString(),
                        ),
                      ),
                      title: Text(post.title.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((ctx) => EditPostScreen(
                                      title: post.title,
                                      description: post.description,
                                      imageUrl: post.imageUrl,
                                      index: i)),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              box.deleteAt(i);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const AddPostScreen(),
              ),
            );
          },
          label: const Text('Add a Post')),
    );
  }
}
