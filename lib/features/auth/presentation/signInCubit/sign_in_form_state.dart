part of 'sign_in_form_cubit.dart';

class SignInFormState extends Equatable {
  const SignInFormState({
    this.email = '',
    this.password = '',
    this.isObscure = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  final String email;
  final String password;
  final bool isObscure;
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  @override
  List<Object?> get props {
    return [email, password, isObscure, isLoading, isSuccess, error];
  }

  SignInFormState copyWith({
    String? email,
    String? password,
    bool? isObscure,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return SignInFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isObscure: isObscure ?? this.isObscure,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }
}
