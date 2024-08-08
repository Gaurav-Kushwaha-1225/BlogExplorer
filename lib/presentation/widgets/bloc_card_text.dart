import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/blog.dart';

class BlogCardText extends StatefulWidget {
  final String title;
  const BlogCardText({super.key, required this.title});

  @override
  State<BlogCardText> createState() => _BlogCardTextState();
}

class _BlogCardTextState extends State<BlogCardText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.48,
      margin:
      const EdgeInsets.only(right: 3, left: 3),
      padding: const EdgeInsets.symmetric(
          horizontal: 1, vertical: 2),
      child: Text(
        widget.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
