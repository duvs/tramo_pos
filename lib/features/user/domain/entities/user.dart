class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.avatarUrl,
    required this.roleId,
    required this.createdAt,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? avatarUrl;
  final String roleId;
  final DateTime createdAt;
}
