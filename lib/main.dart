import 'package:blogexplorer/injection_container.dart';
import 'package:blogexplorer/presentation/bloc/blog_blocs.dart';
import 'package:blogexplorer/presentation/bloc/blog_events.dart';
import 'package:blogexplorer/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  initInjection();
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlogBloc>()..add(LoadBlogs()),
      child: MaterialApp(
        title: "Blog Explorer",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
