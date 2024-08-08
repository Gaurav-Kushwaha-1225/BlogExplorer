
import 'package:bloc/bloc.dart';
import 'package:blogexplorer/presentation/bloc/blog_events.dart';
import 'package:blogexplorer/presentation/bloc/blog_states.dart';

import '../../domain/usecases/get_blogs.dart';

class BlogBloc extends Bloc<BlogEvents, BlogStates> {
  final GetBlogs getBlogs;

  BlogBloc({required this.getBlogs}) : super(BlogLoading()) {
    on<LoadBlogs>((event, emit) async {
      emit(BlogLoading());
      try {
        final blogs = await getBlogs.getBlogs();
        emit(BlogLoaded(blogs));
      } catch (e) {
        emit(BlogError(e.toString()));
      }
    });
  }
}