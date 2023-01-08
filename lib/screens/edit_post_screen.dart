import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/models/post.dart';

class EditPostScreen extends StatefulWidget {
  final String? title;
  final String? description;
  final String? imageUrl;
  final int index;

  const EditPostScreen({
    Key? key,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    required this.index,
  }) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();

  XFile? _image;
  String? _title;
  String? _description;

  getImage() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  submitData() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final postBox = Hive.box<Post>('post');
      final post = postBox.getAt(widget.index);
      post?.title = _title ?? widget.title;
      post?.description = _description ?? widget.description;
      post?.imageUrl = _image?.path ?? widget.imageUrl;
      postBox.putAt(widget.index,
          post!); // Update the value of the post at the given index
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
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
                  initialValue: widget.title,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  autocorrect: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: widget.description,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  autocorrect: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: getImage,
                        child: const Text('Select Image'),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: submitData,
                        child: const Text('Save Post'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_image != null)
                  Image.file(
                    File(_image!.path),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                if (widget.imageUrl != null)
                  Image.file(
                    File(widget.imageUrl!),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
