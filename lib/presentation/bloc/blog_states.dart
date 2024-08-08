import '../../data/models/blog.dart';

abstract class BlogStates {}

class BlogLoading extends BlogStates {

}

class BlogLoaded extends BlogStates {
  final List<Blog> result;
  BlogLoaded(this.result);
}

class BlogError extends BlogStates {
  final String message;
  BlogError(this.message);
}