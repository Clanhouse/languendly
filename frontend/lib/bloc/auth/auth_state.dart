part of 'auth_bloc.dart';

enum EAuthStatus { init, authenticated, unauthenticated }

class AuthState extends Equatable {
  final Auth? auth;
  final EAuthStatus status;

  const AuthState({
    this.auth,
    this.status = EAuthStatus.init,
  });

  factory AuthState.init() => const AuthState();

  factory AuthState.authenticated({required Auth auth}) {
    return AuthState(auth: auth, status: EAuthStatus.authenticated);
  }

  factory AuthState.unauthenticated() => const AuthState(status: EAuthStatus.unauthenticated);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [auth, status];

  Map<String, dynamic> toMap() {
    return {
      'auth': this.auth?.toMap(),
      'status': Enums.toText(this.status),
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      auth: Auth.fromMap(map),
      status: Enums.toEnum(map['status'], EAuthStatus.values),
    );
  }
}
