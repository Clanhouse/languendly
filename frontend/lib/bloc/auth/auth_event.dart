part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final String? access;
  final String? refresh;

  AuthUserChanged({required this.access, required this.refresh});

  @override
  List<Object?> get props => [access, refresh];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthDeleteRequested extends AuthEvent {}
