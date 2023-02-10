import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _userId = (prefs.getInt('userId') ?? 0);
    if (_userId == 0) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/app', ModalRoute.withName('/login'));
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/app', ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
