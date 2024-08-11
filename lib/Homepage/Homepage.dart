import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wghsoga_app/AllUsers/AllUsers.dart';
import 'package:wghsoga_app/AllUsers/UserDetails.dart';
import 'package:wghsoga_app/Auth/Settings/SettingsScreen.dart';
import 'package:wghsoga_app/Components/loading_dialog.dart';
import 'package:wghsoga_app/Components/stoke_text.dart';
import 'package:wghsoga_app/Events/AllEvents.dart';
import 'package:wghsoga_app/Events/EventDetails.dart';
import 'package:wghsoga_app/Homepage/models/homepage_models.dart';
import 'package:wghsoga_app/News/AllNews.dart';
import 'package:wghsoga_app/News/NewsDetails.dart';
import 'package:wghsoga_app/Notifications/notifications.dart';
import 'package:wghsoga_app/PayDues/PayDuesScreen.dart';
import 'package:wghsoga_app/Projects/AllProjects.dart';
import 'package:wghsoga_app/Projects/ProjectDetails.dart';
import 'package:wghsoga_app/Shop/Shop.dart';
import 'package:wghsoga_app/UserProfile/user_profile.dart';
import 'package:wghsoga_app/constants.dart';
import 'package:http/http.dart' as http;

Future<HomeDataModel> get_home_data() async {
  var token = await getApiPref();
  var user_id = await getUserIDPref();

  final response = await http.get(
    // Uri.parse(hostName + "/api/shop/get-product-details/?product_id=" + user_id.toString()),
    Uri.parse(hostName + "/api/homepage/get-homepage-data/?user_id=$user_id"),
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
      // Store User data ////
      //////////////////////////////
    }
    return HomeDataModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 422 ||
      response.statusCode == 403 ||
      response.statusCode == 400) {
    print(jsonDecode(response.body));
    return HomeDataModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({
    super.key,
  });

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  Future<HomeDataModel>? _futureHomeData;

  int currentHour = DateTime.now().hour;

  // Determine the greeting based on the current hour
  String? greeting;

  @override
  void initState() {
    _futureHomeData = get_home_data();
    super.initState();

    // Get the current hour

    if (currentHour < 12) {
      greeting = 'Good Morning..';
    } else if (currentHour < 17) {
      greeting = 'Good Afternoon..';
    } else {
      greeting = 'Good Evening..';
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_futureHomeData == null) ? buildColumn() : buildFutureBuilder();
  }

  buildColumn() {
    return Scaffold(body: Container());
  }

  FutureBuilder<HomeDataModel> buildFutureBuilder() {
    return FutureBuilder<HomeDataModel>(
        future: _futureHomeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingDialogBox(
              text: 'Please Wait..',
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;

            var homedata = data.data!;
            var user_data = homedata.userData!;
            var notification = homedata.notification!;
            var all_users = homedata.users!;
            var all_events = homedata.events!;
            var all_projects = homedata.projects!;
            var all_news = homedata.news!;

            if (data.message == "Successful") {
              return Scaffold(
                  body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/wes_back2.png'),
                        fit: BoxFit.cover)),
                child: SafeArea(
                  child: Column(
                    children: [
                      appBar(user_data, notification),
                      Expanded(
                          child: Container(
                        child: ListView(
                          children: [
                            allUsersSection(context, all_users, user_data),
                            const SizedBox(
                              height: 10,
                            ),
                            allEventsSection(context, all_events),
                            const SizedBox(
                              height: 10,
                            ),
                            allNewsSection(context, all_news),
                            const SizedBox(
                              height: 10,
                            ),
                            allProjectsSection(context, all_projects),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )),
                      bottomNavigatorTabs(context)
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

  Container appBar(UserData user_data, notification) {
    return Container(
      padding: const EdgeInsets.all(13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting.toString(),
                style: TextStyle(
                    height: 1,
                    color: wesWhite,
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                user_data.firstName ?? "",
                style: const TextStyle(
                    height: 1,
                    color: wesWhite,
                    fontSize: 36,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.search,
                size: 30,
                color: wesYellow,
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const NotificationsScreen()));
                },
                child: Stack(
                  children: [
                    Icon(
                      Icons.notifications_active_outlined,
                      size: 30,
                      color: wesYellow,
                    ),
                    if (notification == true) ...[
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: wesYellow,
                          radius: 5,
                        ),
                      )
                    ],
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
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
                                  offset: const Offset(2, 4), // Shadow position
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const UserProfileScreen()));
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        hostName + user_data.photo!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(500),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 2,
                                      offset:
                                          const Offset(2, 4), // Shadow position
                                    ),
                                  ],
                                ),
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
          )
        ],
      ),
    );
  }

  Container allUsersSection(BuildContext context, all_users, user_data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: wesWhite.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user_data.yearGroup + ' Year Group',
                style: TextStyle(
                    height: 1,
                    color: wesYellow,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const AllUsersScreen()));
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                      height: 1,
                      color: wesWhite,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            //color: Colors.red,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: all_users.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => UserDetailScreen(
                                  user_id: all_users[index].userId,
                                )));
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                  color: wesYellow,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 2,
                                      offset:
                                          const Offset(2, 4), // Shadow position
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 1,
                                right: 1,
                                child: Container(
                                  height: 71,
                                  width: 71,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          hostName + all_users[index].photo),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 2,
                                        offset: const Offset(
                                            2, 4), // Shadow position
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            all_users[index].firstName,
                            style: TextStyle(
                                height: 1,
                                color: wesWhite,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Container allEventsSection(BuildContext context, all_events) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: wesWhite.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Latest Events',
                style: TextStyle(
                    height: 1,
                    color: wesYellow,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const AllEvents()));
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                      height: 1,
                      color: wesWhite,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 150,
            //color: Colors.red,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: all_events.length,
              itemBuilder: (context, index) {
                DateTime date = DateTime.parse(all_events[index].eventDate);

                return Row(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => EventDetails(
                                      event_id: all_events[index].eventId,
                                    )));
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 120,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: wesYellow,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 2,
                                      offset:
                                          const Offset(2, 4), // Shadow position
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 1,
                                right: 1,
                                child: Container(
                                  height: 117,
                                  width: 170,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(hostName +
                                          all_events[index].eventImage),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 2,
                                        offset: const Offset(
                                            2, 4), // Shadow position
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 10,
                                child: Column(
                                  children: [
                                    StrokedText(
                                      text: date.day.toString(),
                                      strokeWidth: 5.0,
                                      strokeColor: wesGreen,
                                      textColor: wesYellow,
                                      fontSize: 48.0,
                                    ),
                                    StrokedText(
                                      text: DateFormat('MMMM').format(
                                          DateTime.parse(date.toString())),
                                      strokeWidth: 5.0,
                                      strokeColor: wesGreen,
                                      textColor: wesWhite,
                                      fontSize: 20.0,
                                    ),
                                    StrokedText(
                                      text: date.year.toString(),
                                      strokeWidth: 5.0,
                                      strokeColor: wesGreen,
                                      textColor: wesWhite,
                                      fontSize: 20.0,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                            width: 180,
                            child: Text(
                              all_events[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  height: 1,
                                  color: wesWhite,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Container allNewsSection(BuildContext context, all_news) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: wesWhite.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Latest News',
                style: TextStyle(
                    height: 1,
                    color: wesYellow,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const AllNewsScreen()));
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                      height: 1,
                      color: wesWhite,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 230,
            //color: Colors.red,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: all_news.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => NewsDetails(
                                      news_id: all_news[index].newsId,
                                    )));
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 180,
                                width: 240,
                                decoration: BoxDecoration(
                                  color: wesYellow,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 2,
                                      offset:
                                          const Offset(2, 4), // Shadow position
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 1,
                                right: 1,
                                child: Container(
                                  height: 180,
                                  width: 240,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          hostName + all_news[index].newsImage),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 2,
                                        offset: const Offset(
                                            2, 4), // Shadow position
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: 240,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  all_news[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      height: 1,
                                      color: wesYellow,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  all_news[index].content,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      height: 1,
                                      color: wesWhite,
                                      fontSize: 10,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Container allProjectsSection(BuildContext context, all_projects) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: wesWhite.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Projects',
                style: TextStyle(
                    height: 1,
                    color: wesYellow,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const AllProjectsScreen()));
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                      height: 1,
                      color: wesWhite,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 250,
            //color: Colors.red,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: all_projects.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProjectDetails(
                                      project_id: all_projects[index].projectId,
                                    )));
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                width: 330,
                                decoration: BoxDecoration(
                                  color: wesYellow,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 2,
                                      offset:
                                          const Offset(2, 4), // Shadow position
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 1,
                                right: 1,
                                child: Container(
                                  height: 200,
                                  width: 330,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(hostName +
                                          all_projects[index].projectImage),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 2,
                                        offset: const Offset(
                                            2, 4), // Shadow position
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: 330,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  all_projects[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      height: 1,
                                      color: wesYellow,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  all_projects[index].details,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      height: 1,
                                      color: wesWhite,
                                      fontSize: 10,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
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
              /*      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DashboardScreen()));
                    */
            },
            child: const Column(
              children: [
                Icon(
                  Icons.home,
                  color: wesWhite,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                      height: 1,
                      color: wesWhite,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700),
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

  void dispose() {
    super.dispose();
  }
}
