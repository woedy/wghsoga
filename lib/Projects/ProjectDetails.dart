
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:wghsoga_app/constants.dart';

import '../../Components/keyboard_utils.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {

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
                    Text('Projects', style: TextStyle(height: 1, color: wesWhite, fontSize: 18, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                    Icon(Icons.search, color: wesYellow, size: 20,)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 180,
                                  // width: 100,
                                  decoration: BoxDecoration(
                                    color: wesYellow,
                                    borderRadius: BorderRadius.circular(20),
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
                                  left: 1,
                                  right: 1,
                                  child: Container(
                                    height: 175,
                                    //width: 95,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/nyahan.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
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
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Text('Target', style: TextStyle(height: 1, color: wesWhite, fontSize: 14, fontFamily: 'Montserrat',),),

                                SizedBox(
                                  height: 10,
                                ),
                                Text('Ghc 678,000', style: TextStyle(height: 1, color: wesYellow, fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),),

                                SizedBox(
                                  height: 10,
                                ),

                                Stack(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                    ),
                                    Container(
                                      height: 10,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: wesYellow,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                    ),
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
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Column(
                              children: [
                                Text('2022 OGA Fundraising Dinner Dance towards safer transport on the Volta Lake', style: TextStyle(height: 1, color: wesYellow, fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),),
                                SizedBox(
                                  height: 10,
                                ),

                                Text('When it’s in the news, we only wish the victims well but when it’s close to home we wish We had done something at the first instance no matter how small.', style: TextStyle(height: 1, color: wesWhite, fontSize: 14, fontFamily: 'Montserrat',),),
                                SizedBox(
                                  height: 10,
                                ),

                                Text('When it’s in the news, we only wish the victims well but when it’s close to home we wish We had done something at the first instance no matter how small.', style: TextStyle(height: 1, color: wesWhite, fontSize: 14, fontFamily: 'Montserrat',),),
                                SizedBox(
                                  height: 10,
                                ),

                                Text('When it’s in the news, we only wish the victims well but when it’s close to home we wish We had done something at the first instance no matter how small.', style: TextStyle(height: 1, color: wesWhite, fontSize: 14, fontFamily: 'Montserrat',),),
                                SizedBox(
                                  height: 10,
                                ),

                                Text('When it’s in the news, we only wish the victims well but when it’s close to home we wish We had done something at the first instance no matter how small.', style: TextStyle(height: 1, color: wesWhite, fontSize: 14, fontFamily: 'Montserrat',),),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text('Share project', style: TextStyle(height: 1, color: wesWhite, fontSize: 14, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),),
                                SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Image(image: AssetImage('assets/icons/linkedin.png',),height: 20,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image(image: AssetImage('assets/icons/facebook.png',),height: 20,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image(image: AssetImage('assets/icons/insta.png',),height: 20,),

                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: wesYellow,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text('Support', style: TextStyle(fontSize: 12, color: wesGreen),),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: wesGreen,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text('Message', style: TextStyle(fontSize: 12, color: wesYellow),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),

                          ],
                        ),
                      ),
                    ],
                  )
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 15),

                decoration: BoxDecoration(
                  color: wesGreen,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        /*      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DashboardScreen()));
                      */  },
                      child: Column(
                        children: [
                          Icon(Icons.home, color: wesYellow,),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Home', style: TextStyle(height: 1, color: wesYellow, fontSize: 12, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),

                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                      //  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserBookings()));
                      },
                      child: Column(
                        children: [
                          Icon(Icons.shopping_cart, color: wesYellow,),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Shop', style: TextStyle(height: 1, color: wesYellow, fontSize: 12, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),

                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                       // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AllShopsScreen()));


                      },
                      child: Column(
                        children: [
                          Icon(Icons.money, color: wesYellow,),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Pay Dues', style: TextStyle(height: 1, color: wesYellow, fontSize: 12, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),

                        ],
                      ),
                    ),

                    InkWell(
                      onTap: (){

                     //   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChatScreen()));

                      },
                      child: Column(
                        children: [
                          Icon(Icons.settings, color: wesYellow,),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Settings', style: TextStyle(height: 1, color: wesYellow, fontSize: 12, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),


                        ],
                      ),
                    ),

                    InkWell(
                      onTap: (){

                        //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserProfile()));

                      },
                      child: Column(
                        children: [

                          Icon(Icons.account_circle, color: wesYellow,),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Settings', style: TextStyle(height: 1, color: wesYellow, fontSize: 12, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),

                        ],
                      ),
                    ),


                  ],
                ),
              )

            ],
          ),
        ),
      )
    );
  }

}