
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wghsoga_app/All%20Users/models/user_detail_model.dart';
import 'package:wghsoga_app/Components/loading_dialog.dart';
import 'package:wghsoga_app/constants.dart';


import 'package:http/http.dart' as http;


Future<UserDetailModel> get_user_detail(user_id) async {

  var token = await getApiPref();

  final response = await http.get(
    Uri.parse(hostName + "/api/accounts/get-user-details/?user_id=" + user_id.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token '  + token.toString()
    },
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    final result = json.decode(response.body);
    if (result != null) {

      //////////////////////////////
      // Store users Detail data ////
      //////////////////////////////

    }
    return UserDetailModel.fromJson(jsonDecode(response.body));
  } else if (
  response.statusCode == 422 ||
      response.statusCode == 403 ||
      response.statusCode == 400
  ) {
    print(jsonDecode(response.body));
    return UserDetailModel.fromJson(jsonDecode(response.body));
  }   else {

    throw Exception('Failed to load data');
  }
}



class UserDetailScreen extends StatefulWidget {
  final user_id;
  const UserDetailScreen({super.key, required this.user_id});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {



  Future<UserDetailModel>? _futureUserDetails;

  @override
  void initState() {
    _futureUserDetails = get_user_detail(widget.user_id);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return (_futureUserDetails == null) ? buildColumn() : buildFutureBuilder();
  }



  buildColumn() {
    return Scaffold(
      body: Container()
    );
  }




  FutureBuilder<UserDetailModel> buildFutureBuilder() {
    return FutureBuilder<UserDetailModel>(
        future: _futureUserDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingDialogBox(text: 'Please Wait..',);
          }
          else if(snapshot.hasData) {

            var data = snapshot.data!;

            var user_detail = data.data!;

            if(data.message == "Successful") {
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
                                                    image: NetworkImage(hostName + user_detail.photo.toString()),
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
                                                      Text(
                                                        user_detail.firstName.toString() + " " +
                                                        user_detail.middleName.toString() + " " +
                                                        user_detail.lastName.toString() + " "
                                                    , style: TextStyle(height: 1, color: wesWhite, fontSize: 26, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text( user_detail.yearGroup.toString(), style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text( user_detail.yearGroup.toString() , style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      //Text( user_detail.userProfile!.house.toString(), style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image(image: AssetImage('assets/icons/web.png',),height: 20,),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
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
                                                      Text(user_detail.aboutMe.toString(), style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
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
                                                          //Expanded(child: Text(user_detail.userProfile!.profession.toString(), style: TextStyle(height: 1, color: wesWhite, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),)),
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

          return LoadingDialogBox(text: 'Please Wait..',);


        }
    );
  }


  void dispose() {
    super.dispose();
  }

}
