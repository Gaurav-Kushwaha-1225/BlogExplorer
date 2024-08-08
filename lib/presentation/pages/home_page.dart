import 'package:blogexplorer/presentation/bloc/blog_blocs.dart';
import 'package:blogexplorer/presentation/bloc/blog_events.dart';
import 'package:blogexplorer/presentation/bloc/blog_states.dart';
import 'package:blogexplorer/presentation/pages/blog_detailed_page.dart';
import 'package:blogexplorer/presentation/pages/wishlist_page.dart';
import 'package:blogexplorer/presentation/widgets/bloc_card_text.dart';
import 'package:blogexplorer/presentation/widgets/blog_card_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> wishlist = [];

  @override
  void initState() {
    super.initState();
    loadWishlist();
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

  Future<void> refreshData() async {
    BlocProvider.of<BlogBloc>(context).add(LoadBlogs());
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Blog Explorer",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WishlistPage()));
              },
              icon: const Icon(Icons.star_border_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: Center(
          child: BlocBuilder<BlogBloc, BlogStates>(
            builder: (context, state) {
              if (state is BlogLoading) {
                return const CircularProgressIndicator();
              } else if (state is BlogLoaded) {
                return ListView.builder(
                    itemCount: state.result.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlogDetailedPage(
                                      image: state.result[index].image,
                                      title: state.result[index].title)));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlogCardImage(imageLink: state.result[index].image),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlogCardText(title: state.result[index].title),
                                IconButton(
                                    onPressed: () {
                                      if (wishlist
                                          .contains(state.result[index].id)) {
                                        wishlist.remove(state.result[index].id);
                                      } else {
                                        wishlist.add(state.result[index].id);
                                      }
                                      saveWishlist();
                                      setState(() {});
                                    },
                                    icon: Icon(wishlist
                                            .contains(state.result[index].id)
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded))
                              ],
                            )
                          ],
                        ),
                      );
                    });
              } else if (state is BlogError) {
                return const Center(
                    child: Text(
                  "Please check your internet connection \nand try again",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ));
              } else {
                return const Center(
                    child: Text(
                  "No data available. Please check your internet connection and try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ));
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refreshData,
        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor  ,
        child: const Icon(Icons.refresh,),
      ),
    );
  }
}
