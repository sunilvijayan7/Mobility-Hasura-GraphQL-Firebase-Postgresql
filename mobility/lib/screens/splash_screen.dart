import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:en_payroll/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(
        Duration(
          seconds: 3,
        ), () {
      /*FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
        } else {
          //if user has data in firestore check delivery address set or not
          getUserData();
        }
      });*/
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    const colorizeColors = [
      Colors.purple,
      Colors.blue,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 30.0,
      fontFamily: 'Horizon',
      fontWeight: FontWeight.bold
    );

    return Scaffold(
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'EN PAYROLL',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
        ),
      ),
    );
  }
}
