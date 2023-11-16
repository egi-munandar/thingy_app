part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoggedOut extends AuthState {}

final class AuthUser extends AuthState {
  final UserModel user;
  AuthUser({required this.user});
}

final class AuthError extends AuthState {
  final String err;
  AuthError({required this.err});
}
