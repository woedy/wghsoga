import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wghsoga_app/Components/loading_dialog.dart';
import 'package:wghsoga_app/Shop/models/product_detail_model.dart';
import 'package:wghsoga_app/constants.dart';
import 'package:http/http.dart' as http;

Future<ProductDetailModel> get_product_detail(user_id) async {
  var token = await getApiPref();

  final response = await http.get(
    Uri.parse(hostName +
        "/api/shop/get-product-details/?product_id=" +
        user_id.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token $token', //+ token.toString()

      //'Authorization': 'Token '  + token.toString()
    },
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    final result = json.decode(response.body);
    if (result != null) {
      //////////////////////////////
      // Store users Detail data ////
      //////////////////////////////
    }
    return ProductDetailModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 422 ||
      response.statusCode == 403 ||
      response.statusCode == 400) {
    print(jsonDecode(response.body));
    return ProductDetailModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class ShopDetails extends StatefulWidget {
  final product_id;
  const ShopDetails({super.key, required this.product_id});

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  Future<ProductDetailModel>? _futureProductDetails;

  @override
  void initState() {
    _futureProductDetails = get_product_detail(widget.product_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_futureProductDetails == null)
        ? buildColumn()
        : buildFutureBuilder();
  }

  buildColumn() {
    return Scaffold(body: Container());
  }

  FutureBuilder<ProductDetailModel> buildFutureBuilder() {
    return FutureBuilder<ProductDetailModel>(
        future: _futureProductDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingDialogBox(
              text: 'Please Wait..',
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;

            var product_detail = data.data!;

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
                              'Item Detail',
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
                            height: 260,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: product_detail.productImages!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 230,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          color: wesYellow,
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
                                      Positioned(
                                        top: 0,
                                        left: 1,
                                        right: 1,
                                        child: Container(
                                          height: 225,
                                          width: 240,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: NetworkImage(hostName +
                                                  '/media/' +
                                                  product_detail
                                                      .productImages![index]),
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
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product_detail.name ?? '',
                                        style: TextStyle(
                                            height: 1,
                                            color: wesWhite,
                                            fontSize: 20,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_back_ios_new_sharp,
                                          color: wesYellow,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          '2',
                                          style: TextStyle(
                                              height: 1,
                                              color: wesWhite,
                                              fontSize: 18,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(Icons.arrow_forward_ios_sharp,
                                            color: wesYellow, size: 20),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      height: 1,
                                      color: wesYellow,
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  product_detail.description ?? '',
                                  style: TextStyle(
                                      height: 1,
                                      color: wesWhite,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      height: 1,
                                      color: wesYellow,
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "GH₵ " + product_detail.price.toString() ?? '',
                                  style: TextStyle(
                                      height: 1,
                                      color: wesWhite,
                                      fontSize: 30,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: wesYellow,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          'Buy',
                                          style: TextStyle(
                                              fontSize: 15, color: wesGreen),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
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
