import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wghsoga_app/Events/EventDetails.dart';
import 'package:wghsoga_app/constants.dart';
import 'package:wghsoga_app/Events/models/all_events_model.dart';

import '../Components/stoke_text.dart';
import 'package:http/http.dart' as http;

Future<AllEventsModel> get_all_events(
    {int page = 1, Map<String, String>? filters, String? search_query}) async {
  var token = await getApiPref();

  // Construct the query parameters from the filters map
  String filterQuery = '';
  if (filters != null) {
    filters.forEach((key, value) {
      filterQuery += '&$key=$value';
    });
  }

  final String url = hostName +
      '/api/events/get-all-events/?search=${search_query ?? ''}&page=$page$filterQuery';

  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization':
          'Token $token', //+ token.toString()
      //'Authorization': 'Token '  + token.toString()
    },
  );

  if (response.statusCode == 200) {
    return AllEventsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class AllEvents extends StatefulWidget {
  const AllEvents({super.key});

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  Future<AllEventsModel?>? _futureAllEvents;
  List<Events> _allEvents = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  Map<String, String>? _filters;
  String? _searchQuery;

  Future<AllEventsModel?> _fetchEvents({bool loadMore = false}) async {
    if (_isLoading) return Future.error('Loading in progress');

    setState(() {
      _isLoading = true;
    });

    try {
      final eventsData = await get_all_events(
        page: loadMore ? _currentPage + 1 : 1,
        filters: _filters,
        search_query: _searchQuery,
      );

      setState(() {
        if (loadMore) {
          _allEvents.addAll(eventsData.data!.events!);
          _currentPage++;
        } else {
          _allEvents = eventsData.data!.events!;
          _currentPage = 1;
        }
        _totalPages = eventsData.data!.pagination!.totalPages!;
        _isLoading = false;
      });

      if (_allEvents.isEmpty) {
        return null; // Return null when no event are available
      }

      return eventsData;
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
    _futureAllEvents = _fetchEvents();
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
            Expanded(
                child: FutureBuilder<AllEventsModel?>(
                    future: _futureAllEvents,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || _allEvents.isEmpty) {
                        return Center(child: Text('No Events available'));
                      } else {
                        final allEvents = snapshot.data!.data!.events!;
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
                            itemCount: allEvents.length + (_isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == allEvents.length) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EventDetails(
                                              event_id: allEvents[index]
                                                  .eventId
                                                  .toString())));
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(bottom: 3),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 180,
                                                // width: 100,
                                                decoration: BoxDecoration(
                                                  color: wesYellow,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      blurRadius: 2,
                                                      offset: Offset(2,
                                                          4), // Shadow position
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
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        blurRadius: 2,
                                                        offset: Offset(2,
                                                            4), // Shadow position
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
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '2022 OGA Fundraising Dinner Dance towards...',
                                                  style: TextStyle(
                                                      height: 1,
                                                      color: wesYellow,
                                                      fontSize: 16,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Support WGHS NSMQ team',
                                                  style: TextStyle(
                                                    height: 1,
                                                    color: wesWhite,
                                                    fontSize: 15,
                                                    fontFamily: 'Montserrat',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
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
                                        ],
                                      ),
                                    )
                                  ],
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
      _futureAllEvents = _fetchEvents();
    });
  }

  void _resetFilters() {
    setState(() {
      _filters = null; // Reset filters
      _searchQuery = null;
      _currentPage = 1;
      _futureAllEvents = _fetchEvents();
    });
  }
}
