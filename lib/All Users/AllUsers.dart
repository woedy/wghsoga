
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:wghsoga_app/constants.dart';

import '../../Components/keyboard_utils.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {

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
                    Text('All Registered Old Girls', style: TextStyle(height: 1, color: wesWhite, fontSize: 18, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                    Image(
                        height: 50,
                        image: AssetImage('assets/images/group_chat.png',), color: Colors.blue,),
                    Text('Filter', style: TextStyle(height: 1, color: wesYellow, fontSize: 15, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),

                  ],
                ),
              ),

              Expanded(child: Container(
                margin: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index){
                    return  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 3),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 100,

                                child: Stack(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
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
                                        height: 95,
                                        width: 95,
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
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Sandra Bonsu Demi', style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text('sandrabonsu@gmail.com', style: TextStyle(height: 1, color: wesYellow, fontSize: 15, fontFamily: 'Montserrat',),),

                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text('St. Parks House', style: TextStyle(height: 1, color: wesYellow, fontSize: 14, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),

                          Text('View Details', style: TextStyle(height: 1, color: wesYellow, fontSize: 12, fontFamily: 'Montserrat'),),
                        ],
                      ),
                    );
                  },

                ),
              )),

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