
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:wghsoga_app/constants.dart';

import '../../Components/keyboard_utils.dart';

class UpdateSummary extends StatefulWidget {
  const UpdateSummary({super.key});

  @override
  State<UpdateSummary> createState() => _UpdateSummaryState();
}

class _UpdateSummaryState extends State<UpdateSummary> {

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
                          Text('We are all set', style: TextStyle(height:1, color: wesWhite, fontSize: 28, fontFamily: 'Montserrat'),),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Nyahan', style: TextStyle(height:1, color: wesWhite, fontSize: 62, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),),

                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Container(
                        //color: Colors.red,
                        //padding: EdgeInsets.only(top: 100), // Adjust the top padding to create space
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(top: 90, left: 20, right: 20, bottom: 0),
                              height: MediaQuery.of(context).size.height - 100, // Adjust the height to account for the top padding
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SingleChildScrollView(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 70,
                                      ),
                                      Column(
                                        children: [
                                          Text('Nyahan Joana Davis', style: TextStyle(height: 1, color: wesWhite, fontSize: 26, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('nyahandavis@gmail.com', style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('June 2005', style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('St. Wesley House', style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Bio', style: TextStyle(height: 1, color: wesYellow, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text('Ipsum morbi euismod posuere nostra nullam egestas mollis nibh conubia habitasse curabitur.', style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Interests', style: TextStyle(height: 1, color: wesYellow, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Wrap(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: wesYellow,
                                                  borderRadius: BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.1),
                                                      blurRadius: 2,
                                                      offset: Offset(2, 4), // Shadow position
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                    child: Text('Swimming')
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('General', style: TextStyle(height: 1, color: wesYellow, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(child: Text('Profession', style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),)),
                                              Expanded(child: Text('Business', style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Social Media', style: TextStyle(height: 1, color: wesYellow, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Image(image: AssetImage('assets/icons/web.png')),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('www.nyahandavis.com', style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Image(image: AssetImage('assets/icons/linkedin.png')),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('www.nyahandavis.com', style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 160,
                                width: 160,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 160,
                                            width: 160,
                                            decoration: BoxDecoration(
                                              color: wesYellow,
                                              borderRadius: BorderRadius.circular(500),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.4),
                                                  blurRadius: 2,
                                                  offset: Offset(2, 4), // Shadow position
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 7.5,
                                            right: 7.5,
                                            child: Container(
                                              height: 145,
                                              width: 145,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  image: AssetImage('assets/images/nyahan.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.circular(500),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.4),
                                                    blurRadius: 2,
                                                    offset: Offset(2, 4), // Shadow position
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
