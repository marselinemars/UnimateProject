import 'package:flutter/material.dart';
import 'package:unimate/models/post_model.dart';
import 'package:unimate/core/utils/app_imports.dart';
import 'package:unimate/screens/notification/notification_screen.dart';
import '../../services/post_service.dart';
import '../widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<PostModel>> _postsFuture = Future<List<PostModel>>.value([]);

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _postsFuture = PostService.getAllPosts();
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _postsFuture = PostService.getAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/newpost');
                },
                icon: const Icon(
                  Unicons.edit,
                  size: 22,
                  color: primaryColor,
                )),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()),
                    );
                  },
                  icon: const Icon(
                    Unicons.notification,
                    size: 22,
                    color: primaryColor,
                  )),
            )
          ],
          title: const Text("UniMate",
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22))),
      body: Container(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    onChanged: (value) => _handleSearch(),
                    controller: _searchController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      labelText: 'Search',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: backcolor2),
                      hintText: 'Enter search text',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: backcolor2),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: primaryColor,
                      ),
                      suffixIcon: const Icon(
                        Icons.filter_alt_rounded,
                        color: primaryColor,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "Latest Feed",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshPosts,
                  child: FutureBuilder<List<PostModel>>(
                    future: _postsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Placeholder for loading state
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            children: [
                              Text('Error: ${snapshot.error}'),
                              IconButton(
                                  onPressed: _refreshPosts,
                                  icon: const Icon(Icons.refresh))
                            ],
                          ),
                        ); // Error handling
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No posts available');
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return PostCard(post: snapshot.data![index]);
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void _handleSearch() async {
    String searchText = _searchController.text.toLowerCase();

    List<PostModel> allPosts = await PostService.getAllPosts();

    List<PostModel> filteredPosts = allPosts.where((post) {
      return(post.user!.name.toLowerCase().contains(searchText)) ||
            (post.universityTag?.toLowerCase().contains(searchText) ?? false) ||
            (post.yearTag?.toString().contains(searchText) ?? false) ||
            (post.specialtyTag?.toLowerCase().contains(searchText) ?? false);
    }).toList();

    setState(() {
      _postsFuture = Future.value(filteredPosts);
    });
  }
}
