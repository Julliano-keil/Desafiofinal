/// Represents a user profile.
class Profile {
  /// The unique identifier for this profile.
  final int? id;

  /// The image associated with this profile.
  final String? image;

  /// The user ID associated with this profile.
  final int userId;

  /// Constructor for creating a Profile instance.
  Profile({
    this.id,
    required this.userId,
    required this.image,
  });
}
