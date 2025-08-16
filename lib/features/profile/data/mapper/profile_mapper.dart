import 'package:tramo_pos/features/profile/data/model/profile_model.dart';
import 'package:tramo_pos/features/profile/domain/entities/profile.dart';

class ProfileMapper {
  ProfileMapper._();

  static Profile toEntity(ProfileModel profile) {
    return Profile(
      id: profile.id,
      firstName: profile.firstName,
      lastName: profile.lastName,
      email: profile.email,
      roleId: profile.roleId,
      createdAt: profile.createdAt,
    );
  }

  static ProfileModel toModel(Profile profile) {
    return ProfileModel(
      id: profile.id,
      firstName: profile.firstName,
      lastName: profile.lastName,
      email: profile.email,
      roleId: profile.roleId,
      createdAt: profile.createdAt,
    );
  }
}
