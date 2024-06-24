
import 'package:flutter/material.dart';
import 'package:wghsoga_app/constants.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wes_back.png'),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(

          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image(
                    height: 50,
                      image: AssetImage('assets/images/geyhey_logo.png'))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome To', style: TextStyle(color: wesWhite, fontSize: 64, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                  Text('Wesley Girls\' High School', style: TextStyle(color: wesYellow, fontSize: 55, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),),
                  Text('Old Girls\' Association', style: TextStyle(color: wesWhite, fontSize: 35, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),),
                  Text('Live Pure, Speak True, Right Wrong, Follow the King', style: TextStyle(color: wesWhite, fontSize: 15, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),
                ],
              ),

            ],
          ),
        ),
      )
    );
  }
}
