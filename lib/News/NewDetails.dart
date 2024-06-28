import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:wghsoga_app/constants.dart';

import '../../Components/keyboard_utils.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({super.key});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  final _formKey = GlobalKey<FormState>();

  List<FocusNode>? _focusNodes;

  TextEditingController controller = TextEditingController(text: "");
  bool hasError = false;
  String email_token = "";

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
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 3),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 180,
                            // width: 100,
                            decoration: BoxDecoration(
                              color: wesYellow,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 2,
                                  offset: Offset(2, 4), // Shadow position
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
                                  image: AssetImage('assets/images/nyahan.png'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 2,
                                    offset: Offset(2, 4), // Shadow position
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/nyahan.png'),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Nyahan Davis',
                                  style: TextStyle(
                                      height: 1,
                                      color: wesWhite,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Text(
                              'Nov 11, 2022  1 min read',
                              style: TextStyle(
                                  height: 1,
                                  color: wesWhite.withOpacity(0.5),
                                  fontSize: 10,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                            color: wesWhite.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            '2022 OGA Fundraising Dinner Dance towards safer transport on the Volta Lake',
                            style: TextStyle(
                                height: 1,
                                color: wesYellow,
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'When it’s in the news, we only wish the victims well but when it’s close to home we wish We had done something at the first instance no matter how small.',
                            style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'When it’s in the news, we only wish the victims well but when it’s close to home we wish We had done something at the first instance no matter how small.',
                            style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'When it’s in the news, we only wish the victims well but when it’s close to home we wish We had done something at the first instance no matter how small.',
                            style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'When it’s in the news, we only wish the victims well but when it’s close to home we wish We had done something at the first instance no matter how small.',
                            style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Comments',
                            style: TextStyle(
                                height: 1,
                                color: wesWhite,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              AssetImage('assets/images/nyahan.png'),
                                          radius: 15,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Nyahan Davis',
                                          style: TextStyle(
                                              height: 1,
                                              color: wesWhite,
                                              fontSize: 14,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Nov 11, 2022  1 min read',
                                      style: TextStyle(
                                          height: 1,
                                          color: wesWhite.withOpacity(0.5),
                                          fontSize: 10,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                                style: TextStyle(
                                    height: 1,
                                    color: wesWhite,
                                    fontSize: 12,
                                    fontFamily: 'Montserrat'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                          AssetImage('assets/images/nyahan.png'),
                                          radius: 15,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Nyahan Davis',
                                          style: TextStyle(
                                              height: 1,
                                              color: wesWhite,
                                              fontSize: 14,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Nov 11, 2022  1 min read',
                                      style: TextStyle(
                                          height: 1,
                                          color: wesWhite.withOpacity(0.5),
                                          fontSize: 10,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                                style: TextStyle(
                                    height: 1,
                                    color: wesWhite,
                                    fontSize: 12,
                                    fontFamily: 'Montserrat'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    //color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.1))),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    //hintText: 'Enter Username/Email',

                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                    labelText: "Add Comment",
                                    labelStyle: TextStyle(
                                        fontSize: 13, color: bodyText2),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: wesWhite)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: wesWhite)),
                                    border: InputBorder.none,
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(225),
                                    PasteTextInputFormatter(),
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'First Name is required';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  maxLines: 3,
                                  onSaved: (value) {
                                    setState(() {
                                      //first_name = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: wesGreen,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Add Comment',
                                  style:
                                      TextStyle(fontSize: 12, color: wesYellow),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
}
