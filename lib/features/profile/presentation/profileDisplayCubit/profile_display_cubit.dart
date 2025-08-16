import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tramo_pos/features/profile/domain/entities/profile.dart';
import 'package:tramo_pos/features/profile/domain/repository/profile_repository.dart';

part 'profile_display_state.dart';

class ProfileDisplayCubit extends Cubit<ProfileDisplayState> {
  ProfileDisplayCubit(this._repo) : super(ProfileDisplayInitial());

  final ProfileRepository _repo;

  Future<void> loadMe(String userId) async {
    final result = await _repo.fetchMe(userId);

    result.fold(
      (failure) => emit(ProfileDisplayFailure(failure.message)),
      (profile) => emit(ProfileDisplayLoaded(profile)),
    );
  }
}
