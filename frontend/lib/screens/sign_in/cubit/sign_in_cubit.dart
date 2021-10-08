import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frontend/bloc/bloc.dart';
import 'package:frontend/utilities/utilities.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthBloc _authBloc;

  SignInCubit({required AuthBloc authBloc})
      : _authBloc = authBloc,
        super(SignInState.signIn());

  @override
  Future<void> close() {
    state.controllerEmail.clear();
    state.controllerPassword.clear();
    return super.close();
  }

  changeFormSignIn() {
    emit(state.copyWith(eSignInState: ESignInState.signIn));
  }

  changeFormSignUp() {
    emit(state.copyWith(eSignInState: ESignInState.signUp));
  }

  changeFormReset() {
    emit(state.copyWith(eSignInState: ESignInState.resetPass));
  }

  sign() {
    if (state.formKeyEmail.currentState!.validate() && state.formKeyPassword.currentState!.validate()) {
      if (state.eSignInState == ESignInState.signUp) {
        // _authBloc.sig(email: state.controllerEmail.text, password: state.controllerPassword.text);
      }

      if (state.eSignInState == ESignInState.signIn) {
        _authBloc.singIn(email: state.controllerEmail.text, password: state.controllerPassword.text);
      }
    }
  }
}
