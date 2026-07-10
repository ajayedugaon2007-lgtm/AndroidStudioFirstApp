import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/Workar/registerScreen.dart';

import 'homeScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Icon(
              Icons.favorite,
              color: Colors.white,
              size: 150,
            ),
            SizedBox(height: 20),
            Text(
              "Worker App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}