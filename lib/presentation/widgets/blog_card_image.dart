import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/blog.dart';

class BlogCardImage extends StatefulWidget {
  final String imageLink;
  const BlogCardImage({super.key, required this.imageLink});

  @override
  State<BlogCardImage> createState() => _BlogCardImageState();
}

class _BlogCardImageState extends State<BlogCardImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.width * 0.45,
        margin: const EdgeInsets.only(bottom: 10),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
          child: Image.network(
            widget.imageLink,
            fit: BoxFit.fill,
            errorBuilder: (context, object, trace) {
              return Image.asset(
                "assets/no_image.jpg",
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.13,
              );
            },
          ),
        ));
  }
}
