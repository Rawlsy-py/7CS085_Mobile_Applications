// ignore_for_file: unused_import

import 'dart:io';
import 'package:provider/provider.dart';
import 'package:my_app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screens/add_post_screen.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  // Create the ValueNotifier object
  final boxNotifier = ValueNotifier(Hive.box<Post>('post'));

  final _formKey = GlobalKey<FormState>();

  XFile? _image;
  String? title;
  String? description;

  getImage() async {
    final image =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.getImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  submitData() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      // Use the ValueNotifier object to access the 'post' box
      final box = boxNotifier.value;
      box.add(
        Post(
          title: title!,
          description: description!,
          imageUrl: _image!.path,
          dateTime: DateTime.now().toIso8601String(),
        ),
      );
      // Update the ValueNotifier object
      boxNotifier.value = box;
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize the ValueNotifier object
    boxNotifier.value = Hive.box<Post>('post');
  }

  @override
  void dispose() {
    // Dispose of the ValueNotifier object when the widget is disposed
    boxNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => boxNotifier,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create a Post'),
          actions: [
            IconButton(
              onPressed: submitData,
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                    autocorrect: false,
                    onChanged: (val) {
                      setState(() {
                        title = val;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Description'),
                    ),
                    autocorrect: false,
                    minLines: 2,
                    maxLines: 10,
                    onChanged: (val) {
                      setState(() {
                        description = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  _image == null
                      ? Container()
                      : Image.file(
                          File(_image!.path),
                        ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          child: const Icon(Icons.collections),
        ),
      ),
    );
  }
}
