import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unimate/screens/bookmark.dart';
import 'package:unimate/services/post_service.dart';
import '../../../core/utils/app_imports.dart';
import '../../models/post_model.dart';
import '../comment_screen.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool upvoted;
  late bool downvoted;

  Future<void> _vote(bool isUpvote, bool redo, String postId) async {
    bool success;

    if ((isUpvote && !downvoted) || (!isUpvote && !upvoted)) {
      success = await PostService.vote(isUpvote, redo, postId);

      if (success) {
        setState(() {
          if (isUpvote) {
            upvoted = !upvoted;
            widget.post.upvotes += redo ? -1 : 1;
          } else {
            downvoted = !downvoted;
            widget.post.downvotes += redo ? -1 : 1;
          }
        });
      }
    } else {
      bool successRedoing = await PostService.vote(!isUpvote, true, postId);
      success = await PostService.vote(isUpvote, false, postId);

      if (successRedoing && success) {
        setState(() {
          if (isUpvote) {
            upvoted = !upvoted;
            downvoted = false;
            widget.post.upvotes += redo ? -1 : 1;
            widget.post.downvotes -= redo ? 0 : 1;
          } else {
            downvoted = !downvoted;
            upvoted = false;
            widget.post.upvotes -= redo ? 0 : 1;
            widget.post.downvotes += redo ? -1 : 1;
          }
        });
      }
    }
  }

  @override
  void initState() {
    upvoted = false;
    downvoted = false;
    if (widget.post.postvoted != null) {
      if (widget.post.postvoted == true) {
        upvoted = true;
      } else {
        downvoted = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostModel post = widget.post;
    NetworkImage? cardImage;
    if (post.imageUrl != null) {
      cardImage = NetworkImage(post.imageUrl!);
    }
    // Your timestamp string
    String timestampString = post.createdAt!;

    // Parse the timestamp string into a DateTime object
    DateTime postTime = DateTime.parse(timestampString);

    // Calculate the time difference
    Duration difference = DateTime.now().difference(postTime);

    // Function to format the time
    String formatPostTime() {
      if (difference.inSeconds < 60) {
        return "Just now";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} minutes ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} hours ago";
      } else if (difference.inDays == 1) {
        return "Yesterday";
      } else {
        return DateFormat('yyyy-MM-dd').format(postTime);
      }
    }

    return Card(
      elevation: 1,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: post.user!.avatarUrl != null
                  ? NetworkImage(post.user!.avatarUrl!)
                  : null,
              radius: 25,
            ),
            title: Text(
              post.user!.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: primaryColor),
            ),
            subtitle: Text(
              formatPostTime(),
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: backcolor2),
            ),
            trailing: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return const BookmarkPage();
                  },
                );
              },
              icon: const Icon(
                Unicons.bookmark_border,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Visibility(
                  visible: post.universityTag != '' && post.universityTag != null,
                  child: Ink(
                    child: Text('#${post.universityTag!}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: primaryColor)),
                  ),
                ),
                const SizedBox(width: 10,),
                Visibility(
                  visible: post.specialtyTag != '' && post.specialtyTag != null,
                  child: Ink(
                    child: Text('#${post.specialtyTag}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: primaryColor)),
                  ),
                ),
                const SizedBox(width: 10,),
                Visibility(
                  visible: post.yearTag != '' && post.yearTag != null,
                  child: Ink(
                    child: Text('#${post.yearTag}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: primaryColor)),
                  ),
                )
              ],
            ),
          ),
          if (cardImage != null)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: cardImage,
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              height: MediaQuery.of(context).size.width * 0.95 * 9 / 16,
              width: MediaQuery.of(context).size.width * 0.95,
            ),
          Container(
            margin: const EdgeInsets.only(left: 1),
            padding: const EdgeInsets.fromLTRB(16, 16, 32, 16),
            alignment: Alignment.centerLeft,
            child: Text(
              post.content!,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: backcolor2),
            ),
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 45)),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await _vote(true, upvoted, post.id!);
                    },
                    icon: Icon(
                      Icons.arrow_circle_up_rounded,
                      color: upvoted ? primaryColor : gray,
                      size: 30,
                    ),
                  ),
                  Text(post.upvotes.toString()),
                  IconButton(
                    onPressed: () async {
                      await _vote(false, downvoted, post.id!);
                    },
                    icon: Icon(
                      Icons.arrow_circle_down_rounded,
                      color: downvoted ? primaryColor : gray,
                      size: 30,
                    ),
                  ),
                  Text(post.downvotes.toString()),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommentPage(
                              postId: post.id!,
                            )),
                  );
                },
                icon: const Icon(
                  Unicons.comment,
                  color: primaryColor,
                  size: 28,
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 48)),
            ],
          )
        ],
      ),
    );
  }
}
