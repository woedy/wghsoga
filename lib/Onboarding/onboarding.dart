
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
              Expanded(
                child: PageView(
                  children: [

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image(
                                height: 50,
                                image: AssetImage('assets/images/geyhey_logo.png'))
                          ],
                        ),

                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Welcome to', style: TextStyle(height:1, color: wesWhite, fontSize: 62, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Wesley Girls\' High School', style: TextStyle(height:1.2, color: wesYellow, fontSize: 53, fontFamily: 'Georama', fontWeight: FontWeight.w700),),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text('Old Girls\' Association', style: TextStyle(height:1, color: wesWhite, fontSize: 35, fontWeight: FontWeight.bold),),

                                      SizedBox(
                                        height: 15,
                                      ),

                                      Text('Live Pure, Speak True, Right Wrong, Follow the King', style: TextStyle(height:1, color: wesWhite, fontSize: 15, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                      height: 300,
                                      width: MediaQuery.of(context).size.width,
                                      image: AssetImage('assets/images/onboard1.png'),
                                      fit: BoxFit.cover,),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('Join our vibrant community of empowered women.\nStay connected, share memories, and build\new ones together!',textAlign: TextAlign.center, style: TextStyle(height:1.2, color: wesWhite, fontSize: 15, fontFamily: 'Montserrat',),),


                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [

                        Expanded(
                          child: Column(
                            children: [

                              Expanded(

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                     // height: 300,
                                      width: MediaQuery.of(context).size.width,
                                        image: AssetImage('assets/images/onboard2.png'),
                                    fit: BoxFit.cover,),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Stay Updated', style: TextStyle(height:1.2, color: wesYellow, fontSize: 53, fontFamily: 'Georama', fontWeight: FontWeight.w700),),
                                          Text('Never Miss a Beat!', style: TextStyle(height:1, color: wesWhite, fontSize: 33, fontFamily: 'Georama', fontWeight: FontWeight.w700),),


                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text('Get the latest news, event updates, and announcements. Stay informed and involved in our growing sisterhood.',textAlign: TextAlign.start, style: TextStyle(height:1.2, color: wesWhite, fontSize: 15, fontFamily: 'Montserrat',),),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image(
                                height: 50,
                                image: AssetImage('assets/images/geyhey_logo.png'))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [

                              Expanded(

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                      // height: 300,
                                      width: MediaQuery.of(context).size.width,
                                      image: AssetImage('assets/images/onboard3.png'),
                                      fit: BoxFit.cover,),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Connect and Network', style: TextStyle(height:1.2, color: wesYellow, fontSize: 53, fontFamily: 'Georama', fontWeight: FontWeight.w700),),
                                          Text('Expand Your Network!', style: TextStyle(height:1, color: wesWhite, fontSize: 33, fontFamily: 'Georama', fontWeight: FontWeight.w700),),


                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text('Connect with fellow Old Girls, explore mentorship opportunities, and collaborate on projects. Together, we achieve more!',textAlign: TextAlign.start, style: TextStyle(height:1.2, color: wesWhite, fontSize: 15, fontFamily: 'Montserrat',),),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 3,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    radius: 3,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    radius: 3,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    radius: 3,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),



              Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: wesYellow
                ),
                child: Center(
                  child: Text('Continue', style: TextStyle(fontSize: 15, color: wesGreen),),
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}
