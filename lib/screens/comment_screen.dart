import 'package:flutter/material.dart';

import '../core/utils/app_imports.dart';
import '../models/comment_model.dart';
import '../services/comment_service.dart';
import 'widgets/app_bar.dart';
import 'widgets/comment_card.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.postId});
  final String postId;
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  Future<List<CommentModel>> _commentsFuture =
      Future<List<CommentModel>>.value([]);

  @override
  void initState() {
    super.initState();
    _commentsFuture = CommentService.getAllComments(widget.postId);
  }

  Future<void> _refreshComments() async {
    setState(() {
      _commentsFuture = CommentService.getAllComments(widget.postId);
    });
  }

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniAppBar(appTitle: "Comments"),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshComments,
              child: FutureBuilder<List<CommentModel>>(
                future: _commentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Placeholder for loading state
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          Text('Error: ${snapshot.error}'),
                          IconButton(
                              onPressed: _refreshComments,
                              icon: const Icon(Icons.refresh))
                        ],
                      ),
                    ); // Error handling
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No Comments available');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CommentCard(comment: snapshot.data![index]);
                      },
                    );
                  }
                },
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _commentController,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: primaryColor),
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: backcolor2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () async {
                    if (_commentController.text.trim() != "") {
                      await CommentService.addComment({
                        'postId': widget.postId,
                        'content': _commentController.text.trim()
                      });
                      setState(() {
                        _commentController.clear();
                      });
                    }
                    _refreshComments();
                    FocusScope.of(context).unfocus();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        secondaryColor), // Change background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        primaryColor), // Change font color
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                          color: primaryColor,
                          width: 1.0), // Change border color
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 17.0), // Adjust padding
                    ),
                  ),
                  child: const Text(
                    "Post",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
