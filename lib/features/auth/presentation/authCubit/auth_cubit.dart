import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tramo_pos/features/auth/domain/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo) : super(AuthInitial()) {
    final current = _repo.currentUser();
    emit(current.fold(() => AuthUnauthenticated(), (id) => AuthAuthenticated(id)));
  }
  final AuthRepository _repo;

  Future<void> signOut() => _repo.signOut();
}
