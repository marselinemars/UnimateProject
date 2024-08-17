import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unimate/models/comment_model.dart';
import 'package:unimate/services/comment_service.dart';
import '../../../core/utils/app_imports.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final CommentModel comment;

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool upvoted = false;
  bool downvoted = false;

  Future<void> _vote(bool isUpvote, bool redo, String commentId) async {
    bool success;

    if ((isUpvote && !downvoted) || (!isUpvote && !upvoted)) {
      success = await CommentService.vote(isUpvote, redo, commentId);

      if (success) {
        setState(() {
          if (isUpvote) {
            upvoted = !upvoted;
            widget.comment.upvotes += redo ? -1 : 1;
          } else {
            downvoted = !downvoted;
            widget.comment.downvotes += redo ? -1 : 1;
          }
        });
      }
    } else {
      bool successRedoing =
          await CommentService.vote(!isUpvote, true, commentId);
      success = await CommentService.vote(isUpvote, false, commentId);

      if (successRedoing && success) {
        setState(() {
          if (isUpvote) {
            upvoted = !upvoted;
            downvoted = false;
            widget.comment.upvotes += redo ? -1 : 1;
            widget.comment.downvotes -= redo ? 0 : 1;
          } else {
            downvoted = !downvoted;
            upvoted = false;
            widget.comment.upvotes -= redo ? 0 : 1;
            widget.comment.downvotes += redo ? -1 : 1;
          }
        });
      }
    }
  }

  @override
  void initState() {
    upvoted = false;
    downvoted = false;
    if (widget.comment.commentvoted != null) {
      if (widget.comment.commentvoted == true) {
        upvoted = true;
      } else {
        downvoted = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Your timestamp string
    String timestampString = widget.comment.createdAt!;

    // Parse the timestamp string into a DateTime object
    DateTime postTime = DateTime.parse(timestampString);

    // Calculate the time difference
    Duration difference = DateTime.now().difference(postTime);

    // Function to format the time
    String formatPostTime() {
      if (difference.inSeconds < 60) {
        return "Just now";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} m";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} h";
      } else if (difference.inDays == 1) {
        return "Yesterday";
      } else {
        return DateFormat('yyyy-MM-dd').format(postTime);
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: gray.withOpacity(0.3)))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: widget.comment.user.avatarUrl != null
                    ? NetworkImage(widget.comment.user.avatarUrl!)
                    : null,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.comment.user.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: primaryColor),
                      ),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top:3.0),
                        child: Text(
                          formatPostTime(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: backcolor2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      widget.comment.content,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_circle_up_rounded,
                    color: upvoted ? primaryColor : gray, size: 28,),
                onPressed: () {
                  _vote(true, upvoted, widget.comment.id);
                },
              ),
              Text('${widget.comment.upvotes}'),
              IconButton(
                icon: Icon(Icons.arrow_circle_down_rounded,
                    color: downvoted ? primaryColor : gray, size: 28,),
                onPressed: () {
                  _vote(false, downvoted, widget.comment.id);
                },
              ),
              Text('${widget.comment.downvotes}'),
            ],
          ),
          // if (comment.replies != null)
          //   ...comment.replies!.map((reply) {
          //     return Container(
          //         padding: const EdgeInsets.only(left: 16, top: 8),
          //         child: CommentWidget(reply));
          //   }).toList(),
        ],
      ),
    );
  }
}
