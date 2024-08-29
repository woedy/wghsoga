import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wghsoga_app/Auth/Settings/SettingsScreen.dart';
import 'package:wghsoga_app/Homepage/Homepage.dart';
import 'package:wghsoga_app/PayDues/PayDuesScreen.dart';
import 'package:wghsoga_app/Shop/ShopDetails.dart';
import 'package:wghsoga_app/Shop/models/all_products_model.dart';
import 'package:wghsoga_app/UserProfile/user_profile.dart';
import 'package:wghsoga_app/constants.dart';
import 'package:http/http.dart' as http;

Future<AllProductsModel> get_all_products(
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
      '/api/shop/get-all-products/?search=${search_query ?? ''}&page=$page$filterQuery';

  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization':
          'Token $token', 
    },
  );

  if (response.statusCode == 200) {
    return AllProductsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  Future<AllProductsModel?>? _futureAllProducts;
  List<Products> _allProducts = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  Map<String, String>? _filters;
  String? _searchQuery;

  Future<AllProductsModel?> _fetchProducts({bool loadMore = false}) async {
    if (_isLoading) return Future.error('Loading in progress');

    setState(() {
      _isLoading = true;
    });

    try {
      final productsData = await get_all_products(
        page: loadMore ? _currentPage + 1 : 1,
        filters: _filters,
        search_query: _searchQuery,
      );

      setState(() {
        if (loadMore) {
          _allProducts.addAll(productsData.data!.products!);
          _currentPage++;
        } else {
          _allProducts = productsData.data!.products!;
          _currentPage = 1;
        }
        _totalPages = productsData.data!.pagination!.totalPages!;
        _isLoading = false;
      });

      if (_allProducts.isEmpty) {
        return null; // Return null when no users are available
      }

      return productsData;
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
    _futureAllProducts = _fetchProducts();
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
                    'Shop',
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
                child: FutureBuilder<AllProductsModel?>(
                    future: _futureAllProducts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || _allProducts.isEmpty) {
                        return Center(child: Text('No Product available'));
                      } else {
                        final allProducts = snapshot.data!.data!.products!;
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 10, // Spacing between columns
                            mainAxisSpacing: 10, // Spacing between rows
                          ),
                          padding:
                              EdgeInsets.all(10), // Padding around the grid
                          itemCount: allProducts.length + (_isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == allProducts.length) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopDetails(
                                            product_id: allProducts[index]
                                                .productId
                                                .toString())));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: wesWhite.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 120,
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
                                            height: 120,
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
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Organ Dedication Broch..',
                                            style: TextStyle(
                                              height: 1,
                                              color: wesWhite,
                                              fontSize: 15,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            'GH₵ 150.00',
                                            style: TextStyle(
                                                height: 1,
                                                color: wesYellow,
                                                fontSize: 20,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    })),
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
                  builder: (BuildContext context) => HomepageScreen()));
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
              /*            Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const ShopScreen())); */
            },
            child: const Column(
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: wesWhite,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Shop',
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

  void _applyFilters() {
    setState(() {
      _futureAllProducts = _fetchProducts();
    });
  }

  void _resetFilters() {
    setState(() {
      _filters = null; // Reset filters
      _searchQuery = null;
      _currentPage = 1;
      _futureAllProducts = _fetchProducts();
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
                      items: <String>['Books', 'Digital', 'Stationary']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
