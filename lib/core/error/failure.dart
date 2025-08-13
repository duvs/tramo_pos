import 'package:meta/meta.dart';

@immutable
abstract class Failure {
  const Failure(this.message, {this.cause, this.stackTrace});

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() => '$runtimeType: $message';
}

/// Fallo genérico (si no hay una categoría mejor).
class GenericFailure extends Failure {
  const GenericFailure(super.message, {super.cause, super.stackTrace});
}

/// Errores de red / conectividad.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.cause, super.stackTrace});
}

/// Errores de autenticación/autorización.
class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.cause, super.stackTrace});
}

/// Errores de validación de entrada de usuario.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.cause, super.stackTrace});
}
