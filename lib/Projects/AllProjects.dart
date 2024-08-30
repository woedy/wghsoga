import 'package:flutter/material.dart';
import 'package:wghsoga_app/Projects/ProjectDetails.dart';
import 'package:wghsoga_app/Projects/models/all_projects_model.dart';
import 'package:wghsoga_app/constants.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<AllProjectsModel> get_all_projects(
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
      '/api/projects/get-all-projects/?search=${search_query ?? ''}&page=$page$filterQuery';

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
    return AllProjectsModel.fromJson(jsonDecode(response.body));
  } else {
    print('##################################');
    print(response.body);
    throw Exception('Failed to load data');
  }
}

class AllProjectsScreen extends StatefulWidget {
  const AllProjectsScreen({super.key});

  @override
  State<AllProjectsScreen> createState() => _AllProjectsScreenState();
}

class _AllProjectsScreenState extends State<AllProjectsScreen> {
  List<Projects> _allProjects = [];
  int _currentPage = 1;
  Map<String, String>? _filters;
  Future<AllProjectsModel?>? _futureAllProjects;
  bool _isLoading = false;
  String? _searchQuery;
  int _totalPages = 1;

  @override
  void initState() {
    super.initState();
    _futureAllProjects = _fetchProjects();
  }

  Future<AllProjectsModel?> _fetchProjects({bool loadMore = false}) async {
    if (_isLoading) return Future.error('Loading in progress');

    setState(() {
      _isLoading = true;
    });

    try {
      final projectsData = await get_all_projects(
        page: loadMore ? _currentPage + 1 : 1,
        filters: _filters,
        search_query: _searchQuery,
      );

      setState(() {
        if (loadMore) {
          _allProjects.addAll(projectsData.data!.projects!);
          _currentPage++;
        } else {
          _allProjects = projectsData.data!.projects!;
          _currentPage = 1;
        }
        _totalPages = projectsData.data!.pagination!.totalPages!;
        _isLoading = false;
      });

      if (_allProjects.isEmpty) {
        return null; // Return null when no users are available
      }

      return projectsData;
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
      _futureAllProjects = _fetchProjects();
    });
  }

  void _resetFilters() {
    setState(() {
      _filters = null; // Reset filters
      _searchQuery = null;
      _currentPage = 1;
      _futureAllProjects = _fetchProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: const DecorationImage(
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
                  const Text(
                    'Projects',
                    style: TextStyle(
                        height: 1,
                        color: wesWhite,
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300),
                  ),
                  const Icon(
                    Icons.search,
                    color: wesYellow,
                    size: 20,
                  )
                ],
              ),
            ),

            //  Start - Search Input
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
                style: const TextStyle(color: wesWhite),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                    _currentPage = 1;
                  });
                  _applyFilters();
                },
              ),
            ),

            // End - Search Input

            //  Start - List View Container

            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: FutureBuilder<AllProjectsModel?>(
                  future: _futureAllProjects,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || _allProjects.isEmpty) {
                      return const Center(child: Text('No Projects Available'));
                    } else {
                      final allProjects = snapshot.data!.data!.projects!;

                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!_isLoading &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            if (_currentPage < _totalPages) {
                              _fetchProjects(loadMore: true);
                            }
                            return true;
                          }
                          return false;
                        },
                        child: ListView.builder(
                          itemCount: allProjects.length + (_isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == allProjects.length) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProjectDetails(
                                      project_id: allProjects[index]
                                          .projectId
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(bottom: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 180,
                                          decoration: BoxDecoration(
                                            color: wesYellow,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 2,
                                                offset: const Offset(2, 4),
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
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  hostName +
                                                      '/media/' +
                                                      allProjects[index]
                                                          .projectImages![0],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 2,
                                                  offset: const Offset(2, 4),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          allProjects[index].title ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            height: 1,
                                            color: wesYellow,
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          allProjects[index].details ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            height: 1,
                                            color: wesWhite,
                                            fontSize: 15,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: wesGreen,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Text(
                                        'View Projects',
                                        style: TextStyle(
                                          height: 1,
                                          color: wesYellow,
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
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
            ),
            //  End - List View Container

            // Start - Bottom Navigator
            Container(
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
                      // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AllShopsScreen()));
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
                      //   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChatScreen()));
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
                      //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserProfile()));
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
            //  End - Bottom Navigator
          ],
        ),
      ),
    ));
  }
}
