import 'dart:math';

import 'package:blogexplorer/presentation/widgets/bloc_card_text.dart';
import 'package:blogexplorer/presentation/widgets/blog_card_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/blog.dart';
import '../bloc/blog_blocs.dart';
import '../bloc/blog_states.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<String> wishlist = [];

  @override
  void initState() {
    super.initState();
    loadWishlist();
    debugPrint(wishlist.length.toString());
  }

  loadWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? wishlistString = prefs.getString('wishlist');
    if (wishlistString != null) {
      setState(() {
        String cleanedString =
            wishlistString.substring(1, wishlistString.length - 1);
        List<String> stringList = cleanedString.split(',');
        wishlist = stringList.map((element) => element.trim()).toList();
      });
    }
  }

  saveWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String wishlistString = wishlist.toString();
    prefs.setString('wishlist', wishlistString);
  }

  Blog? findBlogById(List<Blog> blogs, String id) {
    for (int i = 0; i < blogs.length; i++) {
      if (blogs[i].id == id) {
        return blogs[i];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Liked Blogs",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 1,
      ),
      body: wishlist.isEmpty
          ? const Center(
              child: Text(
                "Liked Blogs is Empty",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: Center(
                child: BlocBuilder<BlogBloc, BlogStates>(
                  builder: (context, state) {
                    if (state is BlogLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is BlogLoaded) {
                      return ListView.builder(
                          itemCount: wishlist.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                findBlogById(state.result, wishlist[index]) ==
                                        null
                                    ? const SizedBox()
                                    : BlogCardImage(
                                        imageLink: findBlogById(
                                                state.result, wishlist[index])!
                                            .image),
                                findBlogById(state.result, wishlist[index]) ==
                                        null
                                    ? const SizedBox()
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BlogCardText(
                                              title: findBlogById(state.result,
                                                      wishlist[index])!
                                                  .title)
                                        ],
                                      )
                              ],
                            );
                          });
                    } else if (state is BlogError) {
                      return const Center(
                          child: Text(
                        "Please check your internet connection \nand try again",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ));
                    } else {
                      return const CircularProgressIndicator(
                        color: Colors.red,
                      );
                    }
                  },
                ),
              ),
            ),
    );
  }
}
