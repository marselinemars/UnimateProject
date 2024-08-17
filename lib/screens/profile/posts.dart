import 'package:flutter/material.dart';
import 'package:unimate/models/post_model.dart';
import 'package:unimate/services/profile_service.dart';
import '../widgets/app_bar.dart';
import '../widgets/post_card.dart';
import '../../services/comman_services.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  
Future<List<PostModel>> _postsFuture = Future.value([]);
final ScrollController _scrollController = ScrollController();
void _animateToIndex(int specificPostIndex) {
    _scrollController.animateTo(
      specificPostIndex * 380,
      duration: Duration(milliseconds:900 ),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _postsFuture = Profile.getUserAllPosts(userid: getCurrentUserId());
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _postsFuture =  Profile.getUserAllPosts(userid: getCurrentUserId());
    });
  }

  @override
  Widget build(BuildContext context) {
     final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Access userId and postId
    
    final String postId = arguments['postId'];
    return Scaffold(
     appBar: const UniAppBar(appTitle: 'Posts'),
      body: Container(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [             
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
                        return Text(
                            'Error: ${snapshot.error}'); // Error handling
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                       
                        return
                         Center(
                          child: Column(
                            children: [
                              const Text('No posts available'),
                              IconButton(
                                  onPressed: _refreshPosts,
                                  icon: const Icon(Icons.refresh))
                            ],
                          ),
                        ); // Placeholder for empty state
                      } else {
                      List<PostModel> posts = snapshot.data!;

                      String specificPostId = postId;
                    
                      int specificPostIndex = posts.indexWhere((post) => post.id == specificPostId);

                      // Build the ListView.builder
                      Widget listViewBuilder = ListView.builder(
                        controller: _scrollController,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostCard(post: snapshot.data![index]);
                        },
                      );

                      // Call _animateToIndex after building the ListView.builder
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        _animateToIndex(specificPostIndex);
                      });

                      return listViewBuilder;
                    }
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
