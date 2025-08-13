import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tramo_pos/features/auth/domain/repository/auth_repository.dart';

part 'sign_in_form_state.dart';

class SignInFormCubit extends Cubit<SignInFormState> {
  SignInFormCubit(this._repo) : super(const SignInFormState());
  final AuthRepository _repo;

  Future<void> submit() async {
    emit(state.copyWith(isLoading: true));

    final email = state.email.trim();
    final pass = state.password;

    final res = await _repo.signInWithEmail(email: email, password: pass);
    res.fold(
      (fail) => emit(state.copyWith(isLoading: false, error: fail.message)),
      (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }
}
