import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tramo_pos/core/error/failure.dart';
import 'package:tramo_pos/core/types/result.dart';
import 'package:tramo_pos/features/auth/data/source/auth_supabase_datasource.dart';
import 'package:tramo_pos/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._ds);
  final AuthSupabaseDatasource _ds;

  @override
  Future<Result<Unit>> signInWithEmail({required String email, required String password}) async {
    try {
      await _ds.signIn(email, password);
      return right(unit);
    } on AuthException catch (e, s) {
      return left(AuthFailure(e.message, cause: e, stackTrace: s));
    } catch (e, s) {
      return left(GenericFailure('Error inesperado', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Result<Unit>> signOut() async {
    try {
      await _ds.signOut();
      return right(unit);
    } on AuthException catch (e, s) {
      return left(AuthFailure(e.message, cause: e, stackTrace: s));
    } catch (e, s) {
      return left(GenericFailure('Error inesperado', cause: e, stackTrace: s));
    }
  }

  @override
  Option<String> currentUser() {
    final id = _ds.currentUserId();
    return id == null ? none() : some(id);
  }
}
