import 'package:dartz/dartz.dart';
import 'package:tramo_pos/core/error/failure.dart';
import 'package:tramo_pos/core/types/result.dart';
import 'package:tramo_pos/features/profile/data/source/profile_supabase_datasource.dart';
import 'package:tramo_pos/features/profile/domain/entities/profile.dart';
import 'package:tramo_pos/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRepositoryImpl(this._ds);

  final ProfileSupabaseDatasource _ds;

  @override
  Future<Result<Profile>> fetchMe(String userId) async {
    try {
      final me = await _ds.fetchMe(userId);
      return right(me);
    } catch (e, s) {
      return left(GenericFailure('Error inesperado', cause: e, stackTrace: s));
    }
  }
}
