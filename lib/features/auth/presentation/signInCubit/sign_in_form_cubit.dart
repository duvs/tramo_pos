import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tramo_pos/features/auth/domain/repository/auth_repository.dart';

part 'sign_in_form_state.dart';

class SignInFormCubit extends Cubit<SignInFormState> {
  SignInFormCubit(this._repo) : super(const SignInFormState());
  final AuthRepository _repo;

  Future<void> submit() async {
    final email = state.email.trim();
    final pass = state.password;

    if (email.isEmpty || !email.contains('@')) {
      emit(state.copyWith(error: 'Ingresa un correo válido'));
      return;
    }
    if (pass.length < 6) {
      emit(state.copyWith(error: 'La contraseña debe tener al menos 6 caracteres'));
    }

    emit(state.copyWith(isLoading: true, isSuccess: false));

    final res = await _repo.signInWithEmail(email: email, password: pass);
    res.fold(
      (fail) => emit(state.copyWith(isLoading: false, error: fail.message)),
      (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }

  void updateEmail(String v) => emit(state.copyWith(email: v, isSuccess: false));
  void updatePassword(String v) => emit(state.copyWith(password: v, isSuccess: false));
  void toggleObscure() => emit(state.copyWith(isObscure: !state.isObscure));
}
