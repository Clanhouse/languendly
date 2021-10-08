import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/utilities/utilities.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final storage = FlutterSecureStorage();
  late SharedPreferences prefs;
  late StreamSubscription<String?> _authSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthState.init()) {
    _init();
  }

  @override
  Future<void> close() {
    try {
      _authSubscription.cancel();
    } catch (e) {}
    return super.close();
  }

  void _init() async {
    prefs = await SharedPreferences.getInstance();
    String? access = prefs.getString('access');
    String? refresh = prefs.getString('refresh');

    if (access != null && refresh != null) {
      Logger().i(access);
      add(AuthUserChanged(access: access, refresh: refresh));
    } else {
      add(AuthUserChanged(access: null, refresh: null));
    }
  }

  void singIn({required String email, required String password}) async {
    var response = await _authRepository.signIn(email, password);

    if (response != null) {
      await prefs.setString('access', response['access']!);
      await prefs.setString('refresh', response['refresh']!);
      add(AuthUserChanged(access: response['access']!, refresh: response['refresh']!));
    }
  }

  void singUp({required String email, required String password}) {
    _authRepository.signUp(email, password);
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthUserChanged) {
      yield* _mapAuthUserChangedToState(event);
    } else if (event is AuthLogoutRequested) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? refresh = prefs.getString('refresh');
      if (refresh != null) await _authRepository.refreshToken(refresh);
      await prefs.remove('access');
      await prefs.remove('refresh');
      add(AuthUserChanged(access: null, refresh: null));
    } else if (event is AuthDeleteRequested) {
      // await _authRepository.delete();
    }
  }

  Stream<AuthState> _mapAuthUserChangedToState(AuthUserChanged event) async* {
    if (event.access != null && event.refresh != null) {
      if (state.status != EAuthStatus.authenticated || event.access! != state.access)
        yield AuthState.authenticated(access: event.access!, refresh: event.refresh!);
    } else {
      if (state.status != EAuthStatus.unauthenticated) yield AuthState.unauthenticated();
    }
  }
}
