import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:wghsoga_app/Auth/Settings/SettingsScreen.dart';
import 'package:wghsoga_app/Homepage/Homepage.dart';
import 'package:wghsoga_app/PayDues/dues_entry.dart';
import 'package:wghsoga_app/PayDues/dues_model.dart';
import 'package:wghsoga_app/Shop/Shop.dart';
import 'package:wghsoga_app/UserProfile/user_profile.dart';
import 'package:wghsoga_app/constants.dart';

import '../../Components/keyboard_utils.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<DuesModel> get_all_dues(
    {int page = 1, Map<String, String>? filters, String? search_query}) async {
  var token = await getApiPref();
  var user_id = await getUserIDPref();

  // Construct the query parameters from the filters map
  String filterQuery = '';
  if (filters != null) {
    filters.forEach((key, value) {
      filterQuery += '&$key=$value';
    });
  }

  final String url = hostName +
      '/api/dues/get-all-dues-entries/?search=${search_query ?? ''}&page=$page&user_id=$user_id';

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
    print('##################################');
    print(response.body);
    return DuesModel.fromJson(jsonDecode(response.body));
  } else {
    print('##################################');
    print(response.body);
    throw Exception('Failed to load data');
  }
}

class PayDuesScreen extends StatefulWidget {
  const PayDuesScreen({super.key});

  @override
  State<PayDuesScreen> createState() => _PayDuesScreenState();
}

class _PayDuesScreenState extends State<PayDuesScreen> {
  List<DuesEntries> _allDues = [];
  int _currentPage = 1;
  Map<String, String>? _filters;
  Future<DuesModel?>? _futureAllDues;
  bool _isLoading = false;
  String? _searchQuery;
  int _totalPages = 1;

  String? user_photo;

  @override
  void initState() {
    _loadPhoto();

    super.initState();

    _futureAllDues = _fetchDues();
  }

  Future<void> _loadPhoto() async {
    final photo = await getUserPhoto();
    setState(() {
      user_photo = photo?.replaceAll('"', '');
    });
  }

  Future<DuesModel?> _fetchDues({bool loadMore = false}) async {
    if (_isLoading) return Future.error('Loading in progress');

    setState(() {
      _isLoading = true;
    });

    try {
      final duesData = await get_all_dues(
        page: loadMore ? _currentPage + 1 : 1,
        filters: _filters,
        search_query: _searchQuery,
      );

      setState(() {
        if (loadMore) {
          _allDues.addAll(duesData.data!.duesEntries!);
          _currentPage++;
        } else {
          _allDues = duesData.data!.duesEntries!;
          _currentPage = 1;
        }
        _totalPages = duesData.data!.pagination!.totalPages!;
        _isLoading = false;
      });

      if (_allDues.isEmpty) {
        return null; // Return null when no users are available
      }

      return duesData;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      print('##################################');
      return Future.error('Failed to load data');
    }
  }

  void _applyFilters() {
    setState(() {
      _futureAllDues = _fetchDues();
    });
  }

  void _resetFilters() {
    setState(() {
      _filters = null; // Reset filters
      _searchQuery = null;
      _currentPage = 1;
      _futureAllDues = _fetchDues();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: wesGreen,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 2,
                            offset: const Offset(2, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: wesYellow,
                        ),
                      ),
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
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(
                                    top: 90, left: 20, right: 20, bottom: 0),
                                height:
                                    300, // Adjust the height to account for the top padding
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: SingleChildScrollView(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 70,
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'Outstanding Payment',
                                              style: TextStyle(
                                                  height: 1,
                                                  color: wesYellow,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'GH₵ 150.00',
                                              style: TextStyle(
                                                  height: 1,
                                                  color: Colors.red,
                                                  fontSize: 30,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DuesEntry(
                                                  data: {},
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            width: 200,
                                            decoration: BoxDecoration(
                                                color: wesYellow,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Center(
                                              child: Text(
                                                'Pay Dues Now',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: wesGreen),
                                              ),
                                            ),
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
                                                borderRadius:
                                                    BorderRadius.circular(500),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    blurRadius: 2,
                                                    offset: const Offset(2,
                                                        4), // Shadow position
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
                                                    image: AssetImage(
                                                        'assets/images/default_profile_image.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          500),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      blurRadius: 2,
                                                      offset: const Offset(2,
                                                          4), // Shadow position
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
                                  const Text(
                                    'Past Payments',
                                    style: TextStyle(
                                        height: 1,
                                        color: wesYellow,
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                      child: FutureBuilder<DuesModel?>(
                                          future: _futureAllDues,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                  child: Text(
                                                      'Error: ${snapshot.error}'));
                                            } else if (!snapshot.hasData ||
                                                _allDues.isEmpty) {
                                              return const Center(
                                                  child: Text(
                                                      'No Info Available'));
                                            } else {
                                              final allDues = snapshot
                                                  .data!.data!.duesEntries!;

                                              return NotificationListener<
                                                  ScrollNotification>(
                                                onNotification:
                                                    (ScrollNotification
                                                        scrollInfo) {
                                                  if (!_isLoading &&
                                                      scrollInfo
                                                              .metrics.pixels ==
                                                          scrollInfo.metrics
                                                              .maxScrollExtent) {
                                                    if (_currentPage <
                                                        _totalPages) {
                                                      _fetchDues(
                                                          loadMore: true);
                                                    }
                                                    return true;
                                                  }
                                                  return false;
                                                },
                                                child: ListView.builder(
                                                    itemCount: allDues.length +
                                                        (_isLoading ? 1 : 0),
                                                    itemBuilder:
                                                        (context, index) {
                                                      if (index ==
                                                          allDues.length) {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      }

                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        margin: const EdgeInsets
                                                            .only(bottom: 5),
                                                        decoration: BoxDecoration(
                                                            color: wesWhite
                                                                .withOpacity(
                                                                    0.3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.money,
                                                                  color:
                                                                      wesYellow,
                                                                  size: 25,
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        allDues[index].reference ??
                                                                            "",
                                                                        style: TextStyle(
                                                                            height:
                                                                                1,
                                                                            color:
                                                                                wesWhite,
                                                                            fontSize:
                                                                                16,
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        allDues[index].createdAt ??
                                                                            "",
                                                                        style:
                                                                            TextStyle(
                                                                          height:
                                                                              1,
                                                                          color:
                                                                              wesWhite,
                                                                          fontSize:
                                                                              15,
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Text(
                                                                  'GH₵ ${allDues[index].amount}' ??
                                                                      "",
                                                                  style: TextStyle(
                                                                      height: 1,
                                                                      color: Colors
                                                                          .lightGreenAccent,
                                                                      fontSize:
                                                                          18,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              );
                                            }
                                          })),
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
    ));
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
                  builder: (BuildContext context) => const HomepageScreen()));
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
