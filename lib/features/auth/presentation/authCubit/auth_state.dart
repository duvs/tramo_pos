part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.userId);

  final String userId;

  @override
  List<Object> get props => [userId];
}

final class AuthUnauthenticated extends AuthState {}
