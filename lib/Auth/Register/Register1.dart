import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wghsoga_app/Auth/Register/Register2.dart';
import 'package:wghsoga_app/Auth/SignIn/sign_in_screen.dart';
import 'package:wghsoga_app/Components/keyboard_utils.dart';
import 'package:wghsoga_app/constants.dart';

class Register1 extends StatefulWidget {
  const Register1({super.key});

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  final _formKey = GlobalKey<FormState>();

  String? first_name;
  String? middle_name;
  String? last_name;

  @override
  Widget build(BuildContext context) {
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
                  Container(
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
                              'Let\'s get \nstarted',
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
                              'Tell us about yourself',
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
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    //color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.1))),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    //hintText: 'Enter Username/Email',

                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                    labelText: "First Name *",
                                    labelStyle: TextStyle(
                                        fontSize: 13, color: bodyText2),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: wesWhite)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: wesWhite)),
                                    border: InputBorder.none,
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(225),
                                    PasteTextInputFormatter(),
                                  ],
                                  validator: (value) {
                                    if (value!.length < 3) {
                                      return 'First Name too short';
                                    }

                                    if (value.isEmpty) {
                                      return 'First Name is required';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  onSaved: (value) {
                                    setState(() {
                                      first_name = value;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    //color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.1))),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    //hintText: 'Enter Username/Email',

                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                    labelText: "Middle Name",
                                    labelStyle: TextStyle(
                                        fontSize: 13, color: bodyText2),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: wesWhite)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: wesWhite)),
                                    border: InputBorder.none,
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(225),
                                    PasteTextInputFormatter(),
                                  ],
                                  validator: (value) {},
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  onSaved: (value) {
                                    setState(() {
                                      middle_name = value;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    //color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.1))),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    //hintText: 'Enter Username/Email',

                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                    labelText: "Last Name *",
                                    labelStyle: TextStyle(
                                        fontSize: 13, color: bodyText2),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: wesWhite)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: wesWhite)),
                                    border: InputBorder.none,
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(225),
                                    PasteTextInputFormatter(),
                                  ],
                                  validator: (value) {
                                    if (value!.length < 3) {
                                      return 'Last Name too short';
                                    }
                                    if (value.isEmpty) {
                                      return 'Last Name is required';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  onSaved: (value) {
                                    setState(() {
                                      last_name = value;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    height: 1,
                                    color: wesWhite,
                                    fontSize: 15,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  ' Sign in',
                                  style: TextStyle(
                                      height: 1,
                                      color: wesYellow,
                                      fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
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

                  var payload = {
                    "first_name": first_name,
                    "middle_name": middle_name,
                    "last_name": last_name,
                  };
                  print('############################################');
                  print(payload);
          Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register2(data: payload,)));



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

  void dispose() {
    super.dispose();
  }
}
