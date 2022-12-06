import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/notes.jpeg"),
    fit: BoxFit.cover)),
    );
  }
}
