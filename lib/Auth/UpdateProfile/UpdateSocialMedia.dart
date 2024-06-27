
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:wghsoga_app/constants.dart';

import '../../Components/keyboard_utils.dart';

class UpdateSocialMedia extends StatefulWidget {
  const UpdateSocialMedia({super.key});

  @override
  State<UpdateSocialMedia> createState() => _UpdateSocialMediaState();
}

class _UpdateSocialMediaState extends State<UpdateSocialMedia> {

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
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
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
                          Text('Just one more step', style: TextStyle(height:1, color: wesWhite, fontSize: 28, fontFamily: 'Montserrat'),),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Nyahan', style: TextStyle(height:1, color: wesWhite, fontSize: 62, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),),

                          SizedBox(
                            height: 20,
                          ),
                          Text('Now, we just need your social media handles and website. You know, the places where you put all your exciting updates!', style: TextStyle(height:1.2, color: wesWhite, fontSize: 20, fontFamily: 'Montserrat'),),
                        ],
                      ),
                    ),


                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(20),

                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child:    SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          //color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.white.withOpacity(0.1))),
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            //hintText: 'Enter Username/Email',

                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal),
                                            labelText: "Website",
                                            labelStyle:
                                            TextStyle(fontSize: 13, color: bodyText2),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: wesWhite)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: wesWhite)),
                                            border: InputBorder.none,),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(225),
                                            PasteTextInputFormatter(),
                                          ],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'First Name is required';
                                            }
                                            return null;
                                          },

                                          textInputAction: TextInputAction.next,
                                          autofocus: false,
                                          onSaved: (value) {
                                            setState(() {
                                              //first_name = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,

                                    ),
                                    Image(image: AssetImage('assets/icons/web.png'))
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                 Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          //color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.white.withOpacity(0.1))),
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            //hintText: 'Enter Username/Email',

                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal),
                                            labelText: "LinkedIn",
                                            labelStyle:
                                            TextStyle(fontSize: 13, color: bodyText2),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: wesWhite)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: wesWhite)),
                                            border: InputBorder.none,),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(225),
                                            PasteTextInputFormatter(),
                                          ],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'First Name is required';
                                            }
                                            return null;
                                          },

                                          textInputAction: TextInputAction.next,
                                          autofocus: false,
                                          onSaved: (value) {
                                            setState(() {
                                              //first_name = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,

                                    ),
                                    Image(image: AssetImage('assets/icons/linkedin.png'))
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          //color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.white.withOpacity(0.1))),
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            //hintText: 'Enter Username/Email',

                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal),
                                            labelText: "Instagram",
                                            labelStyle:
                                            TextStyle(fontSize: 13, color: bodyText2),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: wesWhite)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: wesWhite)),
                                            border: InputBorder.none,),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(225),
                                            PasteTextInputFormatter(),
                                          ],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'First Name is required';
                                            }
                                            return null;
                                          },

                                          textInputAction: TextInputAction.next,
                                          autofocus: false,
                                          onSaved: (value) {
                                            setState(() {
                                              //first_name = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,

                                    ),
                                    Image(image: AssetImage('assets/icons/insta.png'))
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),


                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          //color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.white.withOpacity(0.1))),
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            //hintText: 'Enter Username/Email',

                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal),
                                            labelText: "Facebook",
                                            labelStyle:
                                            TextStyle(fontSize: 13, color: bodyText2),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: wesWhite)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: wesWhite)),
                                            border: InputBorder.none,),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(225),
                                            PasteTextInputFormatter(),
                                          ],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'First Name is required';
                                            }
                                            return null;
                                          },

                                          textInputAction: TextInputAction.next,
                                          autofocus: false,
                                          onSaved: (value) {
                                            setState(() {
                                              //first_name = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,

                                    ),
                                    Image(image: AssetImage('assets/icons/facebook.png'))
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),

                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

     


                  ],
                ),
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
