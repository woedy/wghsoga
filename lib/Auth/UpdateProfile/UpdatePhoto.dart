import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:wghsoga_app/constants.dart';

import '../../Components/keyboard_utils.dart';

class UpdatePhoto extends StatefulWidget {
  final data;
  const UpdatePhoto({super.key, required this.data});

  @override
  State<UpdatePhoto> createState() => _UpdatePhotoState();
}

class _UpdatePhotoState extends State<UpdatePhoto> {
  final _formKey = GlobalKey<FormState>();

  List<FocusNode>? _focusNodes;

  TextEditingController controller = TextEditingController(text: "");
  bool hasError = false;
  String email_token = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
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
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: wesGreen,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 2,
                            offset: Offset(2, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: wesYellow,
                        ),
                      ),
                    ),
                  ),
                  Image(
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
                    padding: const EdgeInsets.all(20.0),
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
                          'Nyahan',
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
                          'This is your chance to make your profile dazzle!',
                          style: TextStyle(
                              height: 1.2,
                              color: wesWhite,
                              fontSize: 20,
                              fontFamily: 'Montserrat'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 400,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                                //color: Colors.red
                                ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        //: Colors.red
                                        ),
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 4, color: wesYellow),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        //color: Colors.green
                                        ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                //color: Colors.black
                                ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
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
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: wesYellow),
              child: Center(
                child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 15, color: wesGreen),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
