import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wghsoga_app/Events/EventDetails.dart';
import 'package:wghsoga_app/Notifications/models/notifications_models.dart';
import 'package:wghsoga_app/constants.dart';

import '../Components/stoke_text.dart';
import 'package:http/http.dart' as http;

Future<NotificationsModel> get_all_notifications({int page = 1}) async {
  var token = await getApiPref();
  var user_id = await getUserIDPref();

  final String url = hostName +
      '/api/notifications/get-all-notifications/?user_id=p4vgixrh72xoqzsb1oy4jzy42yza0s135hwe&page=$page';

  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token $token', //+ token.toString()
      //'Authorization': 'Token '  + token.toString()
    },
  );

  if (response.statusCode == 200) {
    return NotificationsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Future<NotificationsModel?>? _futureAllNotifications;
  List<Notifications> _allNotifications = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;

  Future<NotificationsModel?> _fetchEvents({bool loadMore = false}) async {
    if (_isLoading) return Future.error('Loading in progress');

    setState(() {
      _isLoading = true;
    });

    try {
      final notificationsData =
          await get_all_notifications(page: loadMore ? _currentPage + 1 : 1);

      setState(() {
        if (loadMore) {
          _allNotifications.addAll(notificationsData.data!.notifications!);
          _currentPage++;
        } else {
          _allNotifications = notificationsData.data!.notifications!;
          _currentPage = 1;
        }
        _totalPages = notificationsData.data!.pagination!.totalPages!;
        _isLoading = false;
      });

      if (_allNotifications.isEmpty) {
        return null; // Return null when no event are available
      }

      return notificationsData;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      return Future.error('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureAllNotifications = _fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
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
                    'Notifications',
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
            Expanded(
                child: FutureBuilder<NotificationsModel?>(
                    future: _futureAllNotifications,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          _allNotifications.isEmpty) {
                        return Center(child: Text('No Events available'));
                      } else {
                        final allNotifications =
                            snapshot.data!.data!.notifications!;
                        return NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (!_isLoading &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              if (_currentPage < _totalPages) {
                                _fetchEvents(loadMore: true);
                              }
                              return true;
                            }
                            return false;
                          },
                          child: ListView.builder(
                            itemCount:
                                allNotifications.length + (_isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == allNotifications.length) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                      color: wesWhite.withOpacity(0.1)),
                                  child: ListTile(
                                    title: Text(
                                      allNotifications[index]
                                          .subject
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        allNotifications[index]
                                            .content
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                    leading: Icon(
                                      Icons.notifications,
                                      color: wesWhite,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    })),
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

  void _applyFilters() {
    setState(() {
      _futureAllNotifications = _fetchEvents();
    });
  }

  void _resetFilters() {
    setState(() {
      _currentPage = 1;
      _futureAllNotifications = _fetchEvents();
    });
  }
}
