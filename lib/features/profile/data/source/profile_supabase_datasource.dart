import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tramo_pos/features/profile/data/mapper/profile_mapper.dart';
import 'package:tramo_pos/features/profile/data/model/profile_model.dart';
import 'package:tramo_pos/features/profile/domain/entities/profile.dart';

class ProfileSupabaseDatasource {
  ProfileSupabaseDatasource(this._sb);
  final SupabaseClient _sb;

  static const String table = 'profiles';

  Future<Profile> fetchMe(String userId) async {
    final data = await _sb.from(table).select().eq('id', userId).limit(1).single();
    return ProfileMapper.toEntity(ProfileModel.fromMap(data));
  }
}
