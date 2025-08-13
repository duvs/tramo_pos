import 'package:dartz/dartz.dart';
import 'package:tramo_pos/core/types/result.dart';

abstract class AuthRepository {
  Future<Result<Unit>> signInWithEmail({required String email, required String password});
  Future<Result<Unit>> signOut();
  Option<String> currentUser();
}
