class Profile {
  final int? id;

  final String? image;
  final String text;
  final String? imageback;
  final int userId;

  Profile({
    this.id,
    required this.userId,
    required this.image,
    required this.text,
    required this.imageback,
  });
}
