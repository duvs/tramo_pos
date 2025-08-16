class ProfileModel {
  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.avatarUrl,
    required this.roleId,
    required this.createdAt,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String,
      avatarUrl: map['avatar_url'] != null ? map['avatar_url'] as String : null,
      roleId: map['role_id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? avatarUrl;
  final String roleId;
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'role_id': roleId,
      'created_at': createdAt.toIso8601String(),
    };

    if (avatarUrl != null) map['avatar_url'] = avatarUrl;

    return map;
  }
}
