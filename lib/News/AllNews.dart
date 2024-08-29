import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wghsoga_app/News/NewsDetails.dart';
import 'package:wghsoga_app/News/models/all_news_model.dart';
import 'package:wghsoga_app/constants.dart';

import 'package:http/http.dart' as http;

import '../Components/loading_dialog.dart';

Future<AllNewsModel> get_all_news(
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
      '/api/news/get-all-news/?search=${search_query ?? ''}&page=$page$filterQuery';

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
    return AllNewsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class AllNewsScreen extends StatefulWidget {
  const AllNewsScreen({super.key});

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  Future<AllNewsModel?>? _futureAllNews;
  List<Newss> _allNews = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  Map<String, String>? _filters;
  String? _searchQuery;

  Future<AllNewsModel?> _fetchNews({bool loadMore = false}) async {
    if (_isLoading) return Future.error('Loading in progress');

    setState(() {
      _isLoading = true;
    });

    try {
      final newsData = await get_all_news(
        page: loadMore ? _currentPage + 1 : 1,
        filters: _filters,
        search_query: _searchQuery,
      );

      setState(() {
        if (loadMore) {
          _allNews.addAll(newsData.data!.newss!);
          _currentPage++;
        } else {
          _allNews = newsData.data!.newss!;
          _currentPage = 1;
        }
        _totalPages = newsData.data!.pagination!.totalPages!;
        _isLoading = false;
      });

      if (_allNews.isEmpty) {
        return null; // Return null when no users are available
      }

      return newsData;
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
    _futureAllNews = _fetchNews();
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
                    'News',
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
                child: FutureBuilder<AllNewsModel?>(
                    future: _futureAllNews,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || _allNews.isEmpty) {
                        return Center(child: Text('No news available'));
                      } else {
                        final allNews = snapshot.data!.data!.newss!;
                        return NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (!_isLoading &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              if (_currentPage < _totalPages) {
                                _fetchNews(loadMore: true);
                              }
                              return true;
                            }
                            return false;
                          },
                          child: ListView.builder(
                            itemCount: allNews.length + (_isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == allNews.length) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsDetails(
                                              news_id: allNews[index]
                                                  .newsId
                                                  .toString())));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 3),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10)),
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
                                                  offset: Offset(
                                                      2, 4), // Shadow position
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
                                      Column(
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
                                                fontWeight: FontWeight.w600),
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
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: wesWhite.withOpacity(0.1)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.thumb_up_alt_outlined,
                                                  color: wesYellow,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '9 Likes',
                                                  style: TextStyle(
                                                    height: 1,
                                                    color: wesWhite,
                                                    fontSize: 12,
                                                    fontFamily: 'Montserrat',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.comment,
                                                  color: wesYellow,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '20 Comments',
                                                  style: TextStyle(
                                                    height: 1,
                                                    color: wesWhite,
                                                    fontSize: 12,
                                                    fontFamily: 'Montserrat',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.share,
                                                  color: wesYellow,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '20 Comments',
                                                  style: TextStyle(
                                                    height: 1,
                                                    color: wesWhite,
                                                    fontSize: 12,
                                                    fontFamily: 'Montserrat',
                                                  ),
                                                ),
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
      _futureAllNews = _fetchNews();
    });
  }

  void _resetFilters() {
    setState(() {
      _filters = null; // Reset filters
      _searchQuery = null;
      _currentPage = 1;
      _futureAllNews = _fetchNews();
    });
  }

  void dispose() {
    super.dispose();
  }
}
