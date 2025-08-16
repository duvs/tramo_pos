part of 'profile_display_cubit.dart';

sealed class ProfileDisplayState extends Equatable {
  const ProfileDisplayState();

  @override
  List<Object> get props => [];
}

final class ProfileDisplayInitial extends ProfileDisplayState {}

final class ProfileDisplayLoading extends ProfileDisplayState {}

final class ProfileDisplayLoaded extends ProfileDisplayState {
  const ProfileDisplayLoaded(this.profile);

  final Profile profile;

  @override
  List<Object> get props => [profile];
}

final class ProfileDisplayFailure extends ProfileDisplayState {
  const ProfileDisplayFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
