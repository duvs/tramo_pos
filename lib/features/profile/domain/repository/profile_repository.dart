import 'package:tramo_pos/core/types/result.dart';
import 'package:tramo_pos/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Result<Profile>> fetchMe(String userId);
}
