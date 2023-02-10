import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:path/path.dart';
import 'package:flutter_starter/app/auth_models/email.dart';
import 'package:flutter_starter/app/auth_models/password.dart';
import 'package:flutter_starter/app/auth_models/confirm_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter/app/features/sign_up/index.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    required SignUpBloc signUpBloc,
    Key? key,
  })  : _signUpBloc = signUpBloc,
        super(key: key);

  final SignUpBloc _signUpBloc;

  @override
  SignUpScreenState createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  SignUpScreenState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  emailChanged(value) {
    widget._signUpBloc.add(EmailSignUpChangedEvent(value));
  }

  passwordChanged(value) {
    widget._signUpBloc.add(PasswordSignUpChangedEvent(value));
  }

  confirmPasswordChanged(value) {
    widget._signUpBloc.add(ConfirmPasswordSignUpChangedEvent(value));
  }

  doSignUp() {
    widget._signUpBloc.add(DoSignUpEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
        bloc: widget._signUpBloc,
        listener: (BuildContext context, currentState) {
          if (currentState is SignUpSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/app', ModalRoute.withName('/app'));
          }
        },
        builder: (
          BuildContext context,
          SignUpState currentState,
        ) {
          if (currentState is UnSignUpState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorSignUpState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: ElevatedButton(
                    child: const Text('reload'),
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
          if (currentState is InSignUpState) {
            return Stack(
              children: [
                // Center(child: Text('Login')),
                Positioned(
                  child: TextButton(
                      // style: ButtonStyle(backgroundColor: Colors.red),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(Icons.chevron_left,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color)),
                            TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color))
                          ],
                        ),
                      ),
                      onPressed: () {
                        widget._signUpBloc.add(UnSignUpEvent());
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', ModalRoute.withName('/login'));
                      }),
                  left: 15,
                  top: 50.0,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(currentState.exceptionError,
                              style: TextStyle(color: Colors.red))),
                      SizedBox(height: 25),
                      const Padding(
                          padding:
                              EdgeInsets.only(left: 25, right: 25, bottom: 15),
                          child: Center(
                              child: Text('Sign Up',
                                  style: TextStyle(fontSize: 22)))),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 15),
                          child: TextFormField(
                            initialValue: currentState.email.value.isNotEmpty
                                ? currentState.email.value
                                : '',
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Email',
                              errorText: currentState.email.value.isNotEmpty
                                  ? currentState.email.error?.name
                                  : null,
                            ),
                            onChanged: (value) => emailChanged(value),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 15),
                          child: TextFormField(
                            initialValue: currentState.password.value.isNotEmpty
                                ? currentState.password.value
                                : '',
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              errorText: currentState.password.value.isNotEmpty
                                  ? currentState.password.error?.name
                                  : null,
                            ),
                            obscureText: true,
                            onChanged: (value) => {passwordChanged(value)},
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 15),
                          child: TextFormField(
                            initialValue:
                                currentState.confirmPassword.value.isNotEmpty
                                    ? currentState.confirmPassword.value
                                    : '',
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Confirm Password',
                              errorText:
                                  currentState.confirmPassword.value.isNotEmpty
                                      ? currentState.confirmPassword.error?.name
                                      : null,
                            ),
                            obscureText: true,
                            onChanged: (value) =>
                                {confirmPasswordChanged(value)},
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 0),
                        child: ElevatedButton(
                          // padding: EdgeInsets.zero,
                          child: const Text('Sign Up'),
                          // disabledColor: Colors.blueAccent.withOpacity(0.6),
                          // color: Colors.blueAccent,
                          onPressed: currentState.status.isValidated
                              ? () => doSignUp()
                              : null,
                        ),
                      ),
                    ])
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load([bool isError = false]) {
    widget._signUpBloc.add(LoadSignUpEvent(isError));
  }
}
