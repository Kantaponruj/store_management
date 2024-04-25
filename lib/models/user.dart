class User {
  final String name;
  final String email;
  final String uid;
  final String? profilePic;

  const User({
    required this.name,
    required this.email,
    required this.uid,
    this.profilePic,
  });
}
