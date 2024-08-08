
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:wghsoga_app/Auth/Settings/SettingsScreen.dart';
import 'package:wghsoga_app/Homepage/Homepage.dart';
import 'package:wghsoga_app/Shop/Shop.dart';
import 'package:wghsoga_app/UserProfile/user_profile.dart';
import 'package:wghsoga_app/constants.dart';

import '../../Components/keyboard_utils.dart';

class PayDuesScreen extends StatefulWidget {
  const PayDuesScreen({super.key});

  @override
  State<PayDuesScreen> createState() => _PayDuesScreenState();
}

class _PayDuesScreenState extends State<PayDuesScreen> {

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
            image: AssetImage('assets/images/wes_back2.png'),
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

                    Container(
                      height: 65,
                      width: 65,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    color: wesYellow,
                                    borderRadius: BorderRadius.circular(500),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 2,
                                        offset: Offset(2, 4), // Shadow position
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/nyahan.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(500),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
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

                  ],
                ),
              ),



              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Expanded(
                      child: Container(
                        //color: Colors.red,
                        //padding: EdgeInsets.only(top: 100), // Adjust the top padding to create space
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.only(top: 90, left: 20, right: 20, bottom: 0),
                                  height: 300, // Adjust the height to account for the top padding
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
                                                height: 20,
                                              ),
                                              Text('Outstanding Payment', style: TextStyle(height: 1, color: wesYellow, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text('GH₵ 150.00', style: TextStyle(height: 1, color: Colors.red, fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),),
                                         ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),

                                          Container(
                                            padding: EdgeInsets.all(10),
                                            width: 200,
                                            decoration: BoxDecoration(
                                                color: wesYellow,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(
                                              child: Text('Pay Dues Now', style: TextStyle(fontSize: 15, color: wesGreen),),
                                            ),
                                          )
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

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Past Payments', style: TextStyle(height: 1, color: wesYellow, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),),

                                                 SizedBox(                                                   height: 20,
                                                 )      ,


                                                         Expanded(
                                                             child: ListView.builder(
                                     itemBuilder: (Context, index) {
                                       return Container(
                                         padding: EdgeInsets.all(20),
                                         margin: EdgeInsets.only(bottom: 5),

                                         decoration: BoxDecoration(
                                             color: wesWhite.withOpacity(0.3),
                                             borderRadius: BorderRadius.circular(10)
                                         ),
                                         child: Column(
                                           children: [
                                             Row(
                                               children: [
                                                 Icon(Icons.money, color: wesYellow, size: 25,),
                                                 SizedBox(
                                                   width: 20,
                                                 ),
                                                 Expanded(
                                                   child: Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       Text('Payment of house dues', style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),
                                                       SizedBox(
                                                         height: 10,
                                                       ),
                                                       Text('23 May, 2024', style: TextStyle(height: 1, color: wesWhite, fontSize: 15, fontFamily: 'Montserrat',),),
                                                     ],
                                                   ),
                                                 ),
                                                 SizedBox(
                                                   width: 20,
                                                 ),
                                                 Text('GH₵ 150.00', style: TextStyle(height: 1, color: Colors.lightGreenAccent, fontSize: 18, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),),

                                               ],
                                             ),

                                           ],
                                         ),
                                       );
                                     }
                                                             )
                                                         ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),


              bottomNavigatorTabs(context)

            ],
          ),
        ),
      )
    );
  }

  Container bottomNavigatorTabs(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: wesGreen,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomepageScreen()));
            },
            child: const Column(
              children: [
                Icon(
                  Icons.home,
                  color: wesYellow,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                      height: 1,
                      color: wesYellow,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const ShopScreen())); 
            },
            child: const Column(
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: wesYellow,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Shop',
                  style: TextStyle(
                      height: 1,
                      color: wesYellow,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const PayDuesScreen()));
            },
            child: const Column(
              children: [
                Icon(
                  Icons.money,
                  color: wesWhite,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Pay Dues',
                  style: TextStyle(
                      height: 1,
                      color: wesWhite,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const SettingsScreen()));
            },
            child: const Column(
              children: [
                Icon(
                  Icons.settings,
                  color: wesYellow,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                      height: 1,
                      color: wesYellow,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const UserProfileScreen()));
            },
            child: const Column(
              children: [
                Icon(
                  Icons.account_circle,
                  color: wesYellow,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'User Profile',
                  style: TextStyle(
                      height: 1,
                      color: wesYellow,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
