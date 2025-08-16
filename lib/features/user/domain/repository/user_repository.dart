import 'package:tramo_pos/core/types/result.dart';
import 'package:tramo_pos/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<Result<User>> fetchUser();
}
