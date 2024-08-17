import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wghsoga_app/Auth/UpdateProfile/UpdatePhoto.dart';
import 'package:wghsoga_app/Components/keyboard_utils.dart';
import 'package:wghsoga_app/constants.dart';

class UpdateBio extends StatefulWidget {
  final data;
  const UpdateBio({super.key, required this.data});

  @override
  State<UpdateBio> createState() => _UpdateBioState();
}

class _UpdateBioState extends State<UpdateBio> {
  final _formKey = GlobalKey<FormState>();

  String? bio;

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
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome',
                              style: TextStyle(
                                  height: 1,
                                  color: wesWhite,
                                  fontSize: 28,
                                  fontFamily: 'Montserrat'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.data['first_name'],
                              style: const TextStyle(
                                  height: 1,
                                  color: wesWhite,
                                  fontSize: 62,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Write a brief cool bio..',
                              style: TextStyle(
                                  height: 1.2,
                                  color: wesWhite,
                                  fontSize: 20,
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
                                    labelText: "Bio",
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
                                  maxLines: 4,
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Bio is required or skip';
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      bio = value;
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
                var update_data = {'bio': null};

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdatePhoto(
                            data: widget.data,
                            update_data: update_data,
                          )),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: const Center(
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 15, color: wesWhite),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);

                  if (bio != null) {
                    Map<String, dynamic> update_data = {'bio': bio};

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdatePhoto(
                                data: widget.data,
                                update_data: update_data,
                              )),
                    );
                  }
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
}
