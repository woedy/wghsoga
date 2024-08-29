import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wghsoga_app/AllUsers/UserDetails.dart';
import 'package:wghsoga_app/AllUsers/models/all_users_model.dart';
import 'package:wghsoga_app/constants.dart';
import 'package:http/http.dart' as http;

Future<AllUsersModel> get_all_users(
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
      '/api/accounts/get-all-users/?search=${search_query ?? ''}&page=$page$filterQuery';

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
    print(response.body);
    return AllUsersModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  Future<AllUsersModel?>? _futureAllUsers;
  List<Users> _allUsers = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  Map<String, String>? _filters;
  String? _searchQuery;

  Future<AllUsersModel?> _fetchUsers({bool loadMore = false}) async {
    if (_isLoading) return Future.error('Loading in progress');

    setState(() {
      _isLoading = true;
    });

    try {
      final usersData = await get_all_users(
        page: loadMore ? _currentPage + 1 : 1,
        filters: _filters,
        search_query: _searchQuery,
      );

      setState(() {
        if (loadMore) {
          _allUsers.addAll(usersData.data!.users!);
          _currentPage++;
        } else {
          _allUsers = usersData.data!.users!;
          _currentPage = 1;
        }
        _totalPages = usersData.data!.pagination!.totalPages!;
        _isLoading = false;
      });

      if (_allUsers.isEmpty) {
        return null; // Return null when no users are available
      }

      return usersData;
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
    _futureAllUsers = _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: wesYellow,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'All Registered Old Girls',
                    style: TextStyle(
                        height: 1,
                        color: wesWhite,
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300),
                  ),
                  Row(
                    children: [
                      const Image(
                        height: 50,
                        image: AssetImage(
                          'assets/images/group_chat.png',
                        ),
                        color: Colors.white,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                        onPressed: _showFilterBottomSheet,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //  Search Input

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: wesWhite)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: wesWhite)),
                ),
                style: TextStyle(color: wesWhite),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                    _currentPage = 1;
                  });
                  _applyFilters();
                },
              ),
            ),

            // End Search Input

            Expanded(
              child: FutureBuilder<AllUsersModel?>(
                future: _futureAllUsers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || _allUsers.isEmpty) {
                    return Center(child: Text('No users available'));
                  } else {
                    final allUsers = snapshot.data!.data!.users!;
                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!_isLoading &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          if (_currentPage < _totalPages) {
                            _fetchUsers(loadMore: true);
                          }
                          return true;
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: allUsers.length + (_isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == allUsers.length) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserDetailScreen(
                                          user_id: allUsers[index]
                                              .userId
                                              .toString())));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 3),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                height: 95,
                                                width: 95,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        hostName +
                                                            allUsers[index]
                                                                .photo!
                                                                .toString()),
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
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      (allUsers[index]
                                                                  .firstName ??
                                                              "") +
                                                          " " +
                                                          (allUsers[index]
                                                                  .middleName ??
                                                              "") +
                                                          " " +
                                                          (allUsers[index]
                                                                  .lastName ??
                                                              ""),
                                                      style: TextStyle(
                                                          height: 1,
                                                          color: wesWhite,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      allUsers[index]
                                                          .email!
                                                          .toString(),
                                                      style: TextStyle(
                                                        height: 1,
                                                        color: wesYellow,
                                                        fontSize: 15,
                                                        fontFamily:
                                                            'Montserrat',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                     allUsers[index].house??
                                                          "",
                                                      style: TextStyle(
                                                          height: 1,
                                                          color: wesYellow,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                  Text(
                                    'View Details',
                                    style: TextStyle(
                                        height: 1,
                                        color: wesYellow,
                                        fontSize: 12,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilters() {
    setState(() {
      _futureAllUsers = _fetchUsers();
    });
  }

  void _resetFilters() {
    setState(() {
      _filters = null; // Reset filters
      _searchQuery = null;
      _currentPage = 1;
      _futureAllUsers = _fetchUsers();
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filters',
                    style: TextStyle(color: wesGreen, fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton<String>(
                      hint: Text("Select Year Group"),
                      value: _filters?['year_group'],
                      onChanged: (String? newValue) {
                        setState(() {
                          _filters = _filters ?? {};
                          _filters!['year_group'] = newValue ?? '';
                        });
                      },
                      items: <String>['2020', '2021', '2022', '2023']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.1))),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        //hintText: 'Enter Username/Email',

                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        labelText: "City",
                        labelStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w600),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: wesWhite)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: wesWhite)),
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(225),
                        PasteTextInputFormatter(),
                      ],
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      onChanged: (String? newValue) {
                        setState(() {
                          _filters = _filters ?? {};
                          _filters!['city'] = newValue ?? '';
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          //first_name = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton<String>(
                      hint: Text("Select House"),
                      value: _filters?['house'],
                      onChanged: (String? newValue) {
                        setState(() {
                          _filters = _filters ?? {};
                          _filters!['house'] = newValue ?? '';
                        });
                      },
                      items: <String>['House1', 'House2', 'House3']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _applyFilters();
                        },
                        child: Text(
                          'Apply Filters',
                          style: TextStyle(color: wesGreen),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _resetFilters();
                        },
                        child: Text(
                          'Reset Filters',
                          style: TextStyle(color: wesWhite),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .red, // Change color to indicate reset action
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
