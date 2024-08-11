import 'package:flutter/material.dart';
import 'package:wghsoga_app/Auth/UpdateProfile/UpdateBio.dart';
import 'package:wghsoga_app/Homepage/Homepage.dart';
import 'package:wghsoga_app/constants.dart';

class UpdateOption extends StatefulWidget {
  final data;
  const UpdateOption({super.key, required this.data});

  @override
  State<UpdateOption> createState() => _UpdateOptionState();
}

class _UpdateOptionState extends State<UpdateOption> {
  TextEditingController controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/wes_back.png'),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  const Image(
                      height: 50,
                      image: AssetImage('assets/images/geyhey_logo.png'))
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 28,
                              fontFamily: 'Montserrat'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.data['first_name'],
                          style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 62,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Update your profile to tell us more about you or proceed to dashboard if you are in a hurry....',
                          style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 16,
                              fontFamily: 'Montserrat'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateBio(
                                  data: widget.data,
                                )),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: wesYellow,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          'Update My Profile',
                          style: TextStyle(fontSize: 15, color: wesGreen),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomepageScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: wesYellow,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          'Not now!\nAm in a hurry',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: wesGreen),
                        ),
                      ),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
