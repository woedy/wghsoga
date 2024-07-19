
import 'package:flutter/material.dart';
import 'package:wghsoga_app/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wes_back.png'),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Image.asset('assets/images/geyhey_logo.png'),
        ),
      )
    );
  }
}
