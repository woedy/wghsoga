import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:wghsoga_app/Components/error_dialog.dart';
import 'package:wghsoga_app/Components/keyboard_utils.dart';
import 'package:wghsoga_app/Components/loading_dialog.dart';
import 'package:wghsoga_app/Components/sucess_dialog.dart';
import 'package:wghsoga_app/Homepage/Homepage.dart';
import 'package:wghsoga_app/constants.dart';
import 'package:http/http.dart' as http;

Future<ForgotPasswordModel> verify_email(String email, String email_token) async {
  final response = await http.post(
    Uri.parse(hostName + "/api/accounts/verify-email/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    },
    body: jsonEncode({
      "email": email,
      "email_token": email_token,
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    final result = json.decode(response.body);
    if (result != null) {}
    return ForgotPasswordModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 422 ||
      response.statusCode == 403 ||
      response.statusCode == 400) {
    print(jsonDecode(response.body));
    return ForgotPasswordModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to validate email');
  }
}

class VerifyPasswordEmail extends StatefulWidget {
  final data;
  const VerifyPasswordEmail({super.key, required this.data});

  @override
  State<VerifyPasswordEmail> createState() => _VerifyPasswordEmailState();
}

class _VerifyPasswordEmailState extends State<VerifyPasswordEmail> {
  final _formKey = GlobalKey<FormState>();

  List<FocusNode>? _focusNodes;

  TextEditingController controller = TextEditingController(text: "");
  bool hasError = false;
  String email_token = "";
  Future<ForgotPasswordModel>? _futureVerifyEmail;

  @override
  Widget build(BuildContext context) {
    return (_futureVerifyEmail == null) ? buildColumn() : buildFutureBuilder();
  }

  buildColumn() {
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
                          'Verify Password Email',
                          style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 62,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Secure your account.',
                          style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 28,
                              fontFamily: 'Montserrat'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15)),
                    child: Form(
                      key: _formKey,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter verification code here',
                              style: TextStyle(
                                  height: 1,
                                  color: wesYellow,
                                  fontSize: 12,
                                  fontFamily: 'Montserrat'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: PinCodeTextField(
                                    autofocus: true,
                                    controller: controller,
                                    hideCharacter: false,
                                    highlight: true,
                                    highlightColor: wesYellow,
                                    defaultBorderColor:
                                        Colors.white.withOpacity(0.3),
                                    hasTextBorderColor:
                                        Colors.white.withOpacity(0.2),
                                    highlightPinBoxColor: Colors.transparent,
                                    pinBoxColor: Colors.transparent,
                                    pinBoxRadius: 10,
                                    keyboardType: TextInputType.text,
                                    maxLength: 4,
                                    //maskCharacter: "😎",
                                    onTextChanged: (text) {
                                      setState(() {
                                        hasError = false;
                                      });
                                    },
                                    onDone: (text) {
                                      print("DONE $text");
                                      print(
                                          "DONE CONTROLLER ${controller.text}");
                                      email_token = text.toString();
                                    },
                                    pinBoxWidth: 70,
                                    pinBoxHeight: 70,
                                    //hasUnderline: true,
                                    wrapAlignment: WrapAlignment.spaceAround,
                                    pinBoxDecoration: ProvidedPinBoxDecoration
                                        .defaultPinBoxDecoration,
                                    pinTextStyle: TextStyle(fontSize: 35.0),
                                    pinTextAnimatedSwitcherTransition:
                                        ProvidedPinBoxTextAnimation
                                            .scalingTransition,
                                    pinTextAnimatedSwitcherDuration:
                                        Duration(milliseconds: 300),
                                    highlightAnimationBeginColor: Colors.black,
                                    highlightAnimationEndColor: Colors.white12,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Resend email verification',
                              style: TextStyle(
                                  height: 1,
                                  color: wesYellow,
                                  fontSize: 12,
                                  fontFamily: 'Montserrat'),
                            ),
                          ],
                        ),
                      ),
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
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);

                  _futureVerifyEmail =
                      verify_email(widget.data['email'], email_token);
                }
              },
              child: Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: wesYellow),
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 15, color: wesGreen),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  FutureBuilder<ForgotPasswordModel> buildFutureBuilder() {
    return FutureBuilder<ForgotPasswordModel>(
        future: _futureVerifyEmail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingDialogBox(
              text: 'Please Wait..',
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;

            if (data.message == "Successful") {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomepageScreen()),
                );

                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      // Show the dialog
                      return SuccessDialogBox(text: " Successful");
                    });
              });
            } else if (data.message == "Errors") {
              String? errorKey = snapshot.data!.errors!.keys.firstWhere(
                (key) => key == "email",
                orElse: () => null!,
              );
              if (errorKey != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPassword(
                                data: widget.data,
                              )));

                  String customErrorMessage =
                      snapshot.data!.errors![errorKey]![0];
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return ErrorDialogBox(text: customErrorMessage);
                      });
                });
              }
            }
          }

          return LoadingDialogBox(
            text: 'Please Wait..',
          );
        });
  }
}
