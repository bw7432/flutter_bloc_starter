import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_starter/app/auth_models/email.dart';
import 'package:flutter_starter/app/auth_models/password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter/app/features/login/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    required LoginBloc loginBloc,
    Key? key,
  })  : _loginBloc = loginBloc,
        super(key: key);

  final LoginBloc _loginBloc;

  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  LoginScreenState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  passwordChanged(value) {
    widget._loginBloc.add(PasswordLoginChangedEvent(value));
  }

  emailChanged(value) {
    widget._loginBloc.add(EmailLoginChangedEvent(value));
  }

  doLogin() {
    widget._loginBloc.add(DoLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        bloc: widget._loginBloc,
        listener: (BuildContext context, currentState) {
          if (currentState is LoginSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/app', ModalRoute.withName('/app'));
          }
        },
        builder: (
          BuildContext context,
          LoginState currentState,
        ) {
          if (currentState is UnLoginState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorLoginState) {
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
          if (currentState is InLoginState) {
            return Stack(
              children: [
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
                              child: Text('Login',
                                  style: TextStyle(fontSize: 22)))),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'New Here?',
                                ),
                                const SizedBox(width: 15),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 20)),
                                  onPressed: () {
                                    widget._loginBloc.add(UnLoginEvent());
                                    Navigator.of(context).pushNamed('/sign_up');
                                  },
                                  child: const Text('Sign Up'),
                                )
                                // ElevatedButton(onPressed: () => {}), child: child)
                              ])),
                      // const Padding(
                      //     padding:
                      //         EdgeInsets.only(left: 25, right: 25, bottom: 15),
                      //     child: Text(
                      //         'Note: Create an account to keep your lists if you get a new phone.',
                      //         style: TextStyle(fontSize: 15))),
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
                            onChanged: (value) => {emailChanged(value)},
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
                            left: 25, right: 25, bottom: 0),
                        child: ElevatedButton(
                          // padding: EdgeInsets.zero,
                          child: const Text('Login'),
                          // disabledColor: Colors.blueAccent.withOpacity(0.6),
                          // color: Colors.blueAccent,
                          onPressed: currentState.status.isValidated
                              ? () => doLogin()
                              : null,
                        ),
                      ),
                    ])
              ],
            );
          }
          if (currentState is IsLoginState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Logging in...')
              ],
            ));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load([bool isError = false]) {
    widget._loginBloc.add(LoadLoginEvent(isError));
  }
}
