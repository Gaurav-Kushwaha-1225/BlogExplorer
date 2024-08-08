import 'package:blogexplorer/domain/usecases/get_blogs.dart';
import 'package:blogexplorer/presentation/bloc/blog_blocs.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/api_blog_data_source.dart';
import 'data/repositories/blog_repository_impl.dart';
import 'domain/repositories/blog_repository.dart';


GetIt getIt = GetIt.instance;

void initInjection(){
  try{
    getIt.registerLazySingleton<ApiBlogDataSource>(
            () => ApiBlogDataSource()
    );
    getIt.registerLazySingleton<BlogRepository>(
            () => BlogRepositoryImpl(getIt<ApiBlogDataSource>())
    );
    getIt.registerLazySingleton<GetBlogs>(
            () => GetBlogs(getIt<BlogRepository>())
    );
    getIt.registerFactory(() => BlogBloc(getBlogs: getIt<GetBlogs>()));

  } catch (e){
    rethrow;
  }
}