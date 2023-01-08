import 'dart:io';

import 'package:flutter/material.dart';

class ViewPostScreen extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageUrl;

  const ViewPostScreen({
    Key? key,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.toString()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(
                description!.toString(),
                style: const TextStyle(fontSize: 40),
              ),
              const SizedBox(
                height: 50,
              ),
              imageUrl == null
                  ? Container()
                  : Image.file(
                      File(imageUrl!),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// comment to force commit