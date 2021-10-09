part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final Auth? auth;

  AuthUserChanged({required this.auth});

  @override
  List<Object?> get props => [auth];
}

class AuthRefreshToken extends AuthEvent {
  final Auth? auth;

  AuthRefreshToken({required this.auth});

  @override
  List<Object?> get props => [auth];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthDeleteRequested extends AuthEvent {}
