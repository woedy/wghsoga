
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wghsoga_app/Auth/SignIn/sign_in_screen.dart';
import 'package:wghsoga_app/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{



  AnimationController? _controller;
  Animation<double>? _animation;


  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
      value: 0.5,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );
  }


  @override
  Widget build(BuildContext context) {

    Timer(
        Duration(seconds: 3),
            ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignInScreen()))
    );
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wes_back.png'),
            fit: BoxFit.cover
          )
        ),
        child: ScaleTransition(
          scale: _animation!,
          child: Center(
            child: Image.asset('assets/images/geyhey_logo.png'),
          ),
        ),
      )
    );
  }


  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
