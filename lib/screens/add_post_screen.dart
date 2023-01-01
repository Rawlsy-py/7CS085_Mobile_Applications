import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  final _formKey = GlobalKey<FormState>();

  XFile? _image;
  String? title;
  String? description;

  getImage() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Post'),
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
        child: const Icon(Icons.camera),
      ),
    );
  }
}
