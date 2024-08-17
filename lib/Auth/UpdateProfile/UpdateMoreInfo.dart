import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wghsoga_app/Auth/UpdateProfile/UpdateSocialMedia.dart';
import 'package:wghsoga_app/constants.dart';

class UpdateMoreInfo extends StatefulWidget {
  final data;
  final update_data;

  const UpdateMoreInfo(
      {super.key, required this.data, required this.update_data});

  @override
  State<UpdateMoreInfo> createState() => _UpdateMoreInfoState();
}

class _UpdateMoreInfoState extends State<UpdateMoreInfo> {
  final _formKey = GlobalKey<FormState>();

  String? profession;
  String? job_title;
  String? place_of_work;
  String? city;
  String? house;

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
              child: Column(
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
                          'We will also need these general about you',
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
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15)),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      //color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color:
                                              Colors.white.withOpacity(0.1))),
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      //hintText: 'Enter Username/Email',

                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                      labelText: "Profession",
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
                                    textInputAction: TextInputAction.next,
                                    autofocus: false,
                                    onSaved: (value) {
                                      setState(() {
                                        profession = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      //color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color:
                                              Colors.white.withOpacity(0.1))),
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      //hintText: 'Enter Username/Email',

                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                      labelText: "Job Title",
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
                                    textInputAction: TextInputAction.next,
                                    autofocus: false,
                                    onSaved: (value) {
                                      setState(() {
                                        job_title = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      //color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color:
                                              Colors.white.withOpacity(0.1))),
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      //hintText: 'Enter Username/Email',

                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                      labelText: "Place Of Work",
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
                                    textInputAction: TextInputAction.next,
                                    autofocus: false,
                                    onSaved: (value) {
                                      setState(() {
                                        place_of_work = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      //color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color:
                                              Colors.white.withOpacity(0.1))),
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      //hintText: 'Enter Username/Email',

                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                      labelText: "City",
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
                                    textInputAction: TextInputAction.next,
                                    autofocus: false,
                                    onSaved: (value) {
                                      setState(() {
                                        city = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      //color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color:
                                              Colors.white.withOpacity(0.1))),
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      //hintText: 'Enter Username/Email',

                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                      labelText: "House(Back in school)",
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
                                    textInputAction: TextInputAction.next,
                                    autofocus: false,
                                    onSaved: (value) {
                                      setState(() {
                                        house = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateSocialMedia(
                                  data: widget.data,
                                  update_data: widget.update_data,
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

                      widget.update_data['profession'] = profession;
                      widget.update_data['job_title'] = job_title;
                      widget.update_data['place_of_work'] = place_of_work;
                      widget.update_data['city'] = city;
                      widget.update_data['house'] = house;

                      print(widget.update_data);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateSocialMedia(
                                  data: widget.data,
                                  update_data: widget.update_data,
                                )),
                      );
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
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
