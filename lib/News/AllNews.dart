
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wghsoga_app/constants.dart';


import 'package:http/http.dart' as http;

import '../Components/loading_dialog.dart';
import 'models/all_news_model.dart';


Future<AllNewsModel> get_all_users() async {

  var token = await getApiPref();

  final response = await http.get(
    Uri.parse(hostName + "/api/news/get-all-news/"),
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
      // Store all news data ////
      //////////////////////////////

    }
    return AllNewsModel.fromJson(jsonDecode(response.body));
  } else if (
  response.statusCode == 422 ||
      response.statusCode == 403 ||
      response.statusCode == 400
  ) {
    print(jsonDecode(response.body));
    return AllNewsModel.fromJson(jsonDecode(response.body));
  }   else {

    throw Exception('Failed to load data');
  }
}


class AllNewsScreen extends StatefulWidget {
  const AllNewsScreen({super.key});

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {

  Future<AllNewsModel>? _futureAllNews;




  @override
  Widget build(BuildContext context) {
    return (_futureAllNews == null) ? buildColumn() : buildFutureBuilder();
  }



  buildColumn() {
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
                    Text('News', style: TextStyle(height: 1, color: wesWhite, fontSize: 18, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                    Icon(Icons.search, color: wesYellow, size: 20,)
                  ],
                ),
              ),

              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.red
                  ),
                  child: Center(child: Text('Currently Offline'))),

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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('2022 OGA Fundraising Dinner Dance towards...', style: TextStyle(height: 1, color: wesYellow, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Support WGHS NSMQ team', style: TextStyle(height: 1, color: wesWhite, fontSize: 15, fontFamily: 'Montserrat',),),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 20,
                            decoration: BoxDecoration(
                                color: wesWhite.withOpacity(0.1)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.thumb_up_alt_outlined, color: wesYellow, size: 15,),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('9 Likes', style: TextStyle(height: 1, color: wesWhite, fontSize: 12, fontFamily: 'Montserrat',),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.comment, color: wesYellow, size: 15,),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('20 Comments', style: TextStyle(height: 1, color: wesWhite, fontSize: 12, fontFamily: 'Montserrat',),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.share, color: wesYellow, size: 15,),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('20 Comments', style: TextStyle(height: 1, color: wesWhite, fontSize: 12, fontFamily: 'Montserrat',),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
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




  FutureBuilder<AllNewsModel> buildFutureBuilder() {
    return FutureBuilder<AllNewsModel>(
        future: _futureAllNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingDialogBox(text: 'Please Wait..',);
          }
          else if(snapshot.hasData) {

            var data = snapshot.data!;

            //var all_newss = data.data!.news!;

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
                                Text('News', style: TextStyle(height: 1, color: wesWhite, fontSize: 18, fontFamily: 'Montserrat', fontWeight: FontWeight.w300),),
                                Icon(Icons.search, color: wesYellow, size: 20,)
                              ],
                            ),
                          ),

                          Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.red
                              ),
                              child: Center(child: Text('Currently Offline'))),

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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          Text('2022 OGA Fundraising Dinner Dance towards...', style: TextStyle(height: 1, color: wesYellow, fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Support WGHS NSMQ team', style: TextStyle(height: 1, color: wesWhite, fontSize: 15, fontFamily: 'Montserrat',),),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: wesWhite.withOpacity(0.1)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.thumb_up_alt_outlined, color: wesYellow, size: 15,),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('9 Likes', style: TextStyle(height: 1, color: wesWhite, fontSize: 12, fontFamily: 'Montserrat',),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.comment, color: wesYellow, size: 15,),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('20 Comments', style: TextStyle(height: 1, color: wesWhite, fontSize: 12, fontFamily: 'Montserrat',),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.share, color: wesYellow, size: 15,),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('20 Comments', style: TextStyle(height: 1, color: wesWhite, fontSize: 12, fontFamily: 'Montserrat',),),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
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

          return LoadingDialogBox(text: 'Please Wait..',);


        }
    );
  }


  void dispose() {
    super.dispose();
  }


}