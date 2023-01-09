import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'models/post.dart';
import 'package:my_app/screens/post_screen_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<Post>(PostAdapter());

  // Wait for the 'post' box to be opened before running the rest of the main function
  await Hive.openBox<Post>('post');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => ValueNotifier<Box<Post>>(Hive.box<Post>('post')),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        home: const PostListScreen(),
      ),
    );
  }
}
