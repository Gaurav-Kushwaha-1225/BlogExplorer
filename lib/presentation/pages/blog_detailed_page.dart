import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogDetailedPage extends StatefulWidget {
  final String image;
  final String title;
  const BlogDetailedPage({super.key, required this.image, required this.title});

  @override
  State<BlogDetailedPage> createState() => _BlogDetailedPageState();
}

class _BlogDetailedPageState extends State<BlogDetailedPage> {
  @override
  void initState() {
    super.initState();
    debugPrint(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Blog",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.fill,
                  errorBuilder: (context, object, trace) {
                    return Image.asset(
                      "assets/no_image.jpg",
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                ),
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(right: 15, left: 15),
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            color: Colors.black54,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(right: 15, left: 15),
              child: const Text(
                "Content of Blog to Show",
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ),
          )
        ],
      ),
    );
  }
}
