import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/blog.dart';

class ApiBlogDataSource {
  Future<dynamic> getBlogs() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    final parsed = jsonDecode(response.body)['blogs'] as List<dynamic>;
    return parsed
        .map((blog) => Blog(
              id: blog['id'],
              title: blog['title'],
              image: blog['image_url'],
            ))
        .toList();
  }
}
