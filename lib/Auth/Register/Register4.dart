import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wghsoga_app/Auth/Register/VerifyEmail.dart';
import 'package:wghsoga_app/Auth/Register/models/register_user_model.dart';
import 'package:wghsoga_app/Components/error_dialog.dart';
import 'package:wghsoga_app/Components/keyboard_utils.dart';
import 'package:wghsoga_app/Components/loading_dialog.dart';
import 'package:wghsoga_app/constants.dart';

import 'package:http/http.dart' as http;

Future<RegisterUserModel> register_user(data) async {
  final response = await http.post(
    Uri.parse(hostName + "/api/accounts/register-user/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    },
    body: jsonEncode({
      "email": data['email'],
      "first_name": data['first_name'],
      "middle_name": data['middle_name'],
      "last_name": data['last_name'],
      "username": data['username'],
      "year_group": data['year_group'],
      "phone": data['phone'],
      "password": data['password'],
      "password2": data['password2'],
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    final result = json.decode(response.body);
    if (result != null) {

      print(result['data']['token'].toString());

      await saveIDApiKey(result['data']['token'].toString());
      await saveUserID(result['data']['user_id'].toString());

      await saveUserData(result['data']);

    }
    return RegisterUserModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 422 ||
      response.statusCode == 403 ||
      response.statusCode == 400) {
    print(jsonDecode(response.body));
    return RegisterUserModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to register');
  }
}

class Register4 extends StatefulWidget {
  final data;
  const Register4({super.key, required this.data});

  @override
  State<Register4> createState() => _Register4State();
}

class _Register4State extends State<Register4> {
  final _formKey = GlobalKey<FormState>();

  String? password;
  String? password_confirmation;

  var show_password = false;

  Future<RegisterUserModel>? _futureRegisterUser;

  @override
  Widget build(BuildContext context) {
    return (_futureRegisterUser == null) ? buildColumn() : buildFutureBuilder();
  }

  buildColumn() {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
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
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: wesGreen,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 2,
                            offset: const Offset(2, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: wesYellow,
                        ),
                      ),
                    ),
                  ),
                  const Image(
                      height: 50,
                      image: AssetImage('assets/images/geyhey_logo.png'))
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Password',
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15)),
                        child: Form(
                          key: _formKey,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          //color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.white
                                                  .withOpacity(0.1))),
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                            //hintText: 'Enter Password',
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  show_password =
                                                      !show_password;
                                                });
                                              },
                                              icon: Icon(
                                                show_password
                                                    ? Icons
                                                        .remove_red_eye_outlined
                                                    : Icons.remove_red_eye,
                                                color: Colors.white,
                                              ),
                                            ),
                                            hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal),
                                            labelText: "Password",
                                            labelStyle: const TextStyle(
                                                fontSize: 13, color: bodyText2),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: wesWhite)),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: wesWhite)),
                                            border: InputBorder.none),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(225),
                                          PasteTextInputFormatter(),
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Password is required';
                                          }
                                          if (!RegExp(
                                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#\$%^&*_()\-+=/.,<>?"~`£{}|:;])')
                                              .hasMatch(value)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "- Password must be at least 8 characters long\n- Must include at least one uppercase letter,\n- One lowercase letter, one digit,\n- And one special character"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return '';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            password = value;
                                          });
                                        },
                                        textInputAction: TextInputAction.next,
                                        obscureText:
                                            show_password ? false : true,
                                        onSaved: (value) {
                                          setState(() {
                                            password = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          //color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.white
                                                  .withOpacity(0.1))),
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                            //hintText: 'Enter Password',
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  show_password =
                                                      !show_password;
                                                });
                                              },
                                              icon: Icon(
                                                show_password
                                                    ? Icons
                                                        .remove_red_eye_outlined
                                                    : Icons.remove_red_eye,
                                                color: Colors.white,
                                              ),
                                            ),
                                            hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal),
                                            labelText: "Re-Enter Password",
                                            labelStyle: const TextStyle(
                                                fontSize: 13, color: bodyText2),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: wesWhite)),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: wesWhite)),
                                            border: InputBorder.none),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(225),
                                          PasteTextInputFormatter(),
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Password is required';
                                          }

                                          if (value != password) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            password_confirmation = value;
                                          });
                                        },
                                        textInputAction: TextInputAction.next,
                                        obscureText:
                                            show_password ? false : true,
                                        onSaved: (value) {
                                          setState(() {
                                            password_confirmation = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                                const Text(
                                    "- Password must be at least 8 characters long\n- Must include at least one uppercase letter,\n- One lowercase letter, one digit,\n- And one special character",
                                    style: TextStyle(color: wesYellow)),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
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
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);

                  widget.data['password'] = password;
                  widget.data['password2'] = password_confirmation;

                  print(widget.data);

                  _futureRegisterUser = register_user(widget.data);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: wesYellow),
                child: const Center(
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

  FutureBuilder<RegisterUserModel> buildFutureBuilder() {
    return FutureBuilder<RegisterUserModel>(
        future: _futureRegisterUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingDialogBox(
              text: 'Please Wait..',
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;

            print("#########################");

            if (data.message == "Successful") {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerifyEmail(data: widget.data)),
                  (route) => false, // Remove all previous routes
                );

                /*         showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      // Show the dialog
                      return SuccessDialogBox(text: " Successful");
                    }); */
              });
            } else if (data.message == "Errors") {
              String? errorKey = snapshot.data!.errors!.keys.firstWhere(
                (key) =>
                    key == "password" ||
                    key == "email" ||
                    key == "first_name" ||
                    key == "year_group" ||
                    key == "phone" ||
                    key == "last_name" ||
                    key == "password" ||
                    key == "password2",
                orElse: () => null!,
              );
              if (errorKey != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Register4(
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

          return const LoadingDialogBox(
            text: 'Please Wait..',
          );
        });
  }
}
