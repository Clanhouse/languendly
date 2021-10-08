part of 'auth_bloc.dart';

enum EAuthStatus { init, authenticated, unauthenticated }

class AuthState extends Equatable {
  final String? access;
  final String? refresh;
  final EAuthStatus status;

  const AuthState({
    this.access,
    this.refresh,
    this.status = EAuthStatus.init,
  });

  factory AuthState.init() => const AuthState();

  factory AuthState.authenticated({required String access, required String refresh}) {
    return AuthState(access: access, refresh: refresh, status: EAuthStatus.authenticated);
  }

  factory AuthState.unauthenticated() => const AuthState(status: EAuthStatus.unauthenticated);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [access, refresh, status];
}
