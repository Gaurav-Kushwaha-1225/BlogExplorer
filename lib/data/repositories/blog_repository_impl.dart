import 'package:blogexplorer/domain/repositories/blog_repository.dart';

import '../datasources/api_blog_data_source.dart';

class BlogRepositoryImpl implements BlogRepository {
  final ApiBlogDataSource dataSource;

  BlogRepositoryImpl(this.dataSource);

  @override
  Future<dynamic> fetchBlogs() {
    return dataSource.getBlogs();
  }}