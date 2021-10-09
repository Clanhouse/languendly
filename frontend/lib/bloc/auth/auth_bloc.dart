import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/repositories.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:frontend/utilities/utilities.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthState.init()) {
    _init();
  }

  void _init() async {
    if (state.auth != null) {
      // add(AuthUserChanged(auth: state.auth));
    } else {
      add(AuthUserChanged(auth: null));
    }
  }

  void singIn({required String email, required String password}) async {
    Auth? auth = await _authRepository.signIn(email, password);

    if (auth != null) {
      add(AuthUserChanged(auth: auth));
    }
  }

  void singUp({required String email, required String password}) {
    _authRepository.signUp(email, password);
  }

  signOut() {
    add(AuthLogoutRequested());
  }

  void refreshToken() async {
    if (state.auth != null) {
      String? _access = await _authRepository.refreshToken(state.auth!);

      if (_access != null) {
        add(AuthUserChanged(auth: state.auth!.copyWith(access: _access)));
      } else {
        add(AuthUserChanged(auth: null));
      }
    }
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthUserChanged) {
      yield* _mapAuthUserChangedToState(event);
    } else if (event is AuthLogoutRequested) {
      add(AuthUserChanged(auth: null));
    } else if (event is AuthDeleteRequested) {
      // await _authRepository.delete();
    }
  }

  Stream<AuthState> _mapAuthUserChangedToState(AuthUserChanged event) async* {
    if (event.auth != null) {
      if (state.status != EAuthStatus.authenticated || event.auth!.access != state.auth!.access)
        yield AuthState.authenticated(auth: Auth(access: event.auth!.access, refresh: event.auth!.refresh));
    } else {
      if (state.status != EAuthStatus.unauthenticated) yield AuthState.unauthenticated();
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}
