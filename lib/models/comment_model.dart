import 'user_model.dart';

class CommentModel {
  final String id;
  final String content;
  final String? createdAt;
  int upvotes = 0;
  int downvotes = 0;
  final UserModel user;
  final bool? commentvoted;

  CommentModel(
      {required this.id,
      required this.content,
      this.upvotes = 0,
      this.downvotes = 0,
      required this.createdAt,
      required this.user,
      this.commentvoted});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'].toString(),
      content: json['content'],
      upvotes: int.parse(json['up_votes'].toString()),
      downvotes: int.parse(json['down_votes'].toString()),
      createdAt: json['created_at'],
      commentvoted:
          (json['commentVotes'] != null && json['commentVotes'].isNotEmpty)
              ? json['commentVotes'][0]['vote_type']
              : null,
      user: UserModel(
        id: json['users']['id'],
        name: json['users']['name'],
        email: json['users']['email'],
        avatarUrl: json['users']['avatar_url'],
      ),
    );
  }
}
