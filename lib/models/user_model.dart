class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? bio;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.bio
  });
}
