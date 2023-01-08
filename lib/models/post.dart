import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'post.g.dart';

@HiveType(typeId: 0)
class Post {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? imageUrl;
  @HiveField(3)
  String? dateTime;

  Post({
    this.title,
    this.description,
    this.imageUrl,
    this.dateTime,
  });
}

// comment to force commit