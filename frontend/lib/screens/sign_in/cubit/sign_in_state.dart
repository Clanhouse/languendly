part of 'sign_in_cubit.dart';

enum ESignInState {
  signIn,
  signUp,
  resetPass,
}

class SignInState extends Equatable {
  final ESignInState eSignInState;
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final GlobalKey<FormState> formKeyEmail = GlobalKey();
  final GlobalKey<FormState> formKeyPassword = GlobalKey();

  SignInState({this.eSignInState = ESignInState.signIn});

  factory SignInState.signIn() {
    return SignInState();
  }

  @override
  List<Object> get props => [eSignInState];

  SignInState copyWith({
    ESignInState? eSignInState,
  }) {
    return SignInState(
      eSignInState: eSignInState ?? this.eSignInState,
    );
  }
}
