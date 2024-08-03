import 'package:flutter/material.dart';
import 'package:wghsoga_app/Components/loading_dialog.dart';
import 'package:wghsoga_app/Components/stoke_text.dart';
import 'package:wghsoga_app/Events/models/event_detail_model.dart';
import 'package:wghsoga_app/constants.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<EventDetailModel> get_event_detail(user_id) async {
  var token = await getApiPref();

  final response = await http.get(
    Uri.parse(hostName +
        "/api/events/get-event-details/?event_id=" +
        user_id.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization':
          'Token 080a263af80fbfed5c4def6ec747b2972440315c', //+ token.toString()

      //'Authorization': 'Token '  + token.toString()
    },
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    final result = json.decode(response.body);
    if (result != null) {
      //////////////////////////////
      // Store event Detail data ////
      //////////////////////////////
    }
    return EventDetailModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 422 ||
      response.statusCode == 403 ||
      response.statusCode == 400) {
    print(jsonDecode(response.body));
    return EventDetailModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class EventDetails extends StatefulWidget {
  final event_id;

  const EventDetails({super.key, required this.event_id});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

    Future<EventDetailModel>? _futureEventDetails;

  @override
  void initState() {
    _futureEventDetails = get_event_detail(widget.event_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_futureEventDetails == null) ? buildColumn() : buildFutureBuilder();
  }

  buildColumn() {
    return Scaffold(body: Container());
  }

  FutureBuilder<EventDetailModel> buildFutureBuilder() {
    return FutureBuilder<EventDetailModel>(
        future: _futureEventDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingDialogBox(
              text: 'Please Wait..',
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;

            var events_detail = data.data!;

            if (data.message == "Successful") {
              return Scaffold(
                  body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/wes_back2.png'),
                        fit: BoxFit.cover)),
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
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
                            Text(
                              'Events',
                              style: TextStyle(
                                  height: 1,
                                  color: wesWhite,
                                  fontSize: 18,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w300),
                            ),
                            Icon(
                              Icons.search,
                              color: wesYellow,
                              size: 20,
                            )
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
                                borderRadius: BorderRadius.circular(10)),
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
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 2,
                                            offset:
                                                Offset(2, 4), // Shadow position
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
                                            image: AssetImage(
                                                'assets/images/nyahan.png'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 2,
                                              offset: Offset(
                                                  2, 4), // Shadow position
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        StrokedText(
                                          text: '25',
                                          strokeWidth: 5.0,
                                          strokeColor: wesGreen,
                                          textColor: wesYellow,
                                          fontSize: 48.0,
                                        ),
                                        StrokedText(
                                          text: 'September',
                                          strokeWidth: 5.0,
                                          strokeColor: wesGreen,
                                          textColor: wesWhite,
                                          fontSize: 20.0,
                                        ),
                                        StrokedText(
                                          text: '2024',
                                          strokeWidth: 5.0,
                                          strokeColor: wesGreen,
                                          textColor: wesWhite,
                                          fontSize: 20.0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '2024 Old School Reunion',
                                            style: TextStyle(
                                                height: 1,
                                                color: wesYellow,
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Theme',
                                            style: TextStyle(
                                                height: 1,
                                                color: wesYellow,
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Virtual Education in Ghana:',
                                            style: TextStyle(
                                                height: 1,
                                                color: wesWhite,
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Harnessing the Prospects for National Development.',
                                            style: TextStyle(
                                                height: 1,
                                                color: wesWhite,
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w200),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: StrokedText(
                                        text: 'Time:',
                                        strokeWidth: 5.0,
                                        strokeColor: wesGreen,
                                        textColor: wesYellow,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          '10:00 AM;',
                                          style: TextStyle(
                                            height: 1,
                                            color: wesWhite,
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: StrokedText(
                                        text: 'Venue:',
                                        strokeWidth: 5.0,
                                        strokeColor: wesGreen,
                                        textColor: wesYellow,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Assembly Hall (Virtual – Live on Facebook)',
                                          style: TextStyle(
                                            height: 1,
                                            color: wesWhite,
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: StrokedText(
                                        text: 'Organised by:',
                                        strokeWidth: 5.0,
                                        strokeColor: wesGreen,
                                        textColor: wesYellow,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          '95 year group.',
                                          style: TextStyle(
                                            height: 1,
                                            color: wesWhite,
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                      Container(
                        padding: EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: wesYellow),
                        child: Center(
                          child: Text(
                            'Join Event',
                            style: TextStyle(fontSize: 15, color: wesGreen),
                          ),
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                /*      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DashboardScreen()));
                      */
                              },
                              child: Column(
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
                                //  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserBookings()));
                              },
                              child: Column(
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
                                // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AllShopsScreen()));
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.money,
                                    color: wesYellow,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Pay Dues',
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
                                //   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChatScreen()));
                              },
                              child: Column(
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
                                //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserProfile()));
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.account_circle,
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
            }
          }

          return const LoadingDialogBox(
            text: 'Please Wait..',
          );
        });
  }

  void dispose() {
    super.dispose();
  }

}
