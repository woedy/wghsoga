import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wghsoga_app/AllUsers/models/all_users_model.dart';
import 'package:wghsoga_app/constants.dart';
import 'package:http/http.dart' as http;

Future<AllUsersModel> get_all_users({int page = 1, Map<String, String>? filters, String? search_query}) async {
  var token = await getApiPref();

  // Construct the query parameters from the filters map
  String filterQuery = '';
  if (filters != null) {
    filters.forEach((key, value) {
      filterQuery += '&$key=$value';
    });
  }

  final String url = hostName + '/api/accounts/get-all-users/?search=${search_query ?? ''}&page=$page$filterQuery';

  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token b581d06ebd3e0561e917dfd8c615afa065e66089' //+ token.toString()
    },
  );

  if (response.statusCode == 200) {
    return AllUsersModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class GenericListing extends StatefulWidget {
  const GenericListing({super.key});

  @override
  State<GenericListing> createState() => _GenericListingState();
}

class _GenericListingState extends State<GenericListing> {
  Future<AllUsersModel>? _futureAllUsers;
  List<Users> _allUsers = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  Map<String, String>? _filters;
  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    _futureAllUsers = _fetchUsers();
  }

  Future<AllUsersModel> _fetchUsers({bool loadMore = false}) async {
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

      return usersData;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  void _applyFilters() {
    setState(() {
      _futureAllUsers = _fetchUsers();
    });
  }

  void _resetFilters() {
    setState(() {
      _filters = null;  // Reset filters
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

                  ),
                  SizedBox(height: 16),
                  DropdownButton<String>(
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
                  SizedBox(height: 16),
                  DropdownButton<String>(
                    hint: Text("Select City"),
                    value: _filters?['city'],
                    onChanged: (String? newValue) {
                      setState(() {
                        _filters = _filters ?? {};
                        _filters!['city'] = newValue ?? '';
                      });
                    },
                    items: <String>['Accra', 'Kumasi', 'Tamale']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  DropdownButton<String>(
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
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _applyFilters();
                        },
                        child: Text('Apply Filters'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _resetFilters();
                        },
                        child: Text('Reset Filters'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Change color to indicate reset action
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Search'),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _currentPage = 1;
                });
                _applyFilters();
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<AllUsersModel>(
              future: _futureAllUsers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final allUsers = snapshot.data!.data!.users!;
                  return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!_isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
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
                        return ListTile(
                          title: Text(allUsers[index].email ?? 'No Email'),
                          subtitle: Text(allUsers[index].username ?? 'No Username'),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
