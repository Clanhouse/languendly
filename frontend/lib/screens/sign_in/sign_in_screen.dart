import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/bloc/auth/auth_bloc.dart';
import 'package:frontend/repositories/auth_repository.dart';
import 'package:frontend/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:frontend/utilities/utilities.dart';
import 'package:frontend/widgets/widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static const String routeName = '/sign-in';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(
        authBloc: context.read<AuthBloc>(),
      ),
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: (state.eSignInState == ESignInState.resetPass)
                  ? AppBar(
                      leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => context.read<SignInCubit>().changeFormSignIn(),
                    ))
                  : null,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                      formKeyEmail: state.formKeyEmail,
                      controller: state.controllerEmail,
                      labelText: Strings.email(),
                      validator: (v) => Validators.email(v),
                      icon: Icons.email,
                    ),
                    if (state.eSignInState != ESignInState.resetPass)
                      CustomTextField(
                        formKeyEmail: state.formKeyPassword,
                        controller: state.controllerPassword,
                        labelText: Strings.password(),
                        validator: (v) => Validators.password(v),
                        icon: Icons.lock,
                        obscureText: true,
                      ),
                    CustomButton(
                      onPressed: () => context.read<SignInCubit>().sign(),
                      child: Center(child: Text(_getText(state.eSignInState))),
                    ),
                    if (state.eSignInState == ESignInState.signIn)
                      TextButton(
                          onPressed: () => context.read<SignInCubit>().changeFormReset(),
                          child: Text(
                            Strings.forgot_your_password(),
                            style: TextStyle(color: Colors.white),
                          )),
                    if (state.eSignInState == ESignInState.signUp)
                      TextButton(
                          onPressed: () => context.read<SignInCubit>().changeFormSignIn(),
                          child: Text(Strings.have_account_sign_in(), style: TextStyle(color: Colors.white))),
                    if (state.eSignInState == ESignInState.signIn)
                      TextButton(
                          onPressed: () => context.read<SignInCubit>().changeFormSignUp(),
                          child: Text(Strings.need_register(), style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

String _getText(ESignInState eSignInState) {
  switch (eSignInState) {
    case ESignInState.signIn:
      return Strings.sign_in();

    case ESignInState.signUp:
      return Strings.sign_up();

    case ESignInState.resetPass:
      return Strings.reset_password();
  }
}
