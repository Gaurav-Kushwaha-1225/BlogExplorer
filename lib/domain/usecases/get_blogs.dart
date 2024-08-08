import 'package:blogexplorer/data/models/blog.dart';
import 'package:blogexplorer/domain/repositories/blog_repository.dart';

class GetBlogs {
  final BlogRepository repository;

  GetBlogs(this.repository);

  Future<List<Blog>> getBlogs() async {
    return await repository.fetchBlogs();
  }
}