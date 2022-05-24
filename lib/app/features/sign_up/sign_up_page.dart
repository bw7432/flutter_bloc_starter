import 'package:flutter/material.dart';
import 'package:flutter_starter/app/features/sign_up/index.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signUp';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpBloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('SignUp'),
      // ),
      body: SignUpScreen(signUpBloc: _signUpBloc),
    );
  }
}
