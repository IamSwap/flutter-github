class User {
  final String name;
  final String username;
  final String followers;
  final String following;
  final String bio;
  final String avatar;

  User({this.name, this.username, this.followers, this.following, this.bio, this.avatar});

  factory User.fromJson(Map json) {
    return User(
      name: json['name'] as String,
      username: json['login'] as String,
      followers: "${json['followers']}",
      following: "${json['following']}",
      bio: json['bio'] as String ?? "",
      avatar: json['avatar_url'] as String,
    );
  }
}