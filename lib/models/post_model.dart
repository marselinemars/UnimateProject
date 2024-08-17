import 'user_model.dart';

class PostModel {
  final String? id;
  final String? content;
  final String? imageUrl;
  final List<String> tags;
  final String? universityTag;
  final String? specialtyTag;
  final String? yearTag;
  final String? createdAt;
  int upvotes = 0;
  int downvotes = 0;
  final UserModel? user;
  final bool? postvoted;

  PostModel(
      {this.id,
      this.content,
      this.imageUrl,
      required this.tags,
      this.universityTag,
      this.specialtyTag,
      this.yearTag,
      this.upvotes = 0,
      this.downvotes = 0,
      this.createdAt,
      this.user,
      this.postvoted});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'].toString(),
      content: json['content'],
      imageUrl: json['image_url'],
      tags: List<String>.from(json['tags'] ?? []),
      universityTag: json['university_tag'],
      specialtyTag: json['specialty_tag'],
      yearTag: json['year_tag'],
      upvotes: int.parse(json['up_votes'].toString()),
      downvotes: int.parse(json['down_votes'].toString()),
      createdAt: json['created_at'],
      postvoted: (json['postVotes'] != null && json['postVotes'].isNotEmpty)
          ? json['postVotes'][0]['vote_type']
          : null,
      user: UserModel(
        id: json['users']['id'],
        name: json['users']['name'],
        email: json['users']['email'],
        avatarUrl: json['users']['avatar_url'],
        bio: json['users']['bio'],
      ),
    );
  }
}
