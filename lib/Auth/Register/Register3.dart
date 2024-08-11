import 'package:flutter/material.dart';
import 'package:wghsoga_app/Auth/Register/Register4.dart';
import 'package:wghsoga_app/constants.dart';

class Register3 extends StatefulWidget {
  final data;
  const Register3({super.key, required this.data});

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  String? yearGroup = "1960";

  @override
  void initState() {
    yearGroup = '1960';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/wes_back.png'),
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
                  Image(
                      height: 50,
                      image: AssetImage('assets/images/geyhey_logo.png'))
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tell us your\nyear group',
                          style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 62,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'We will use this to display\ninfo relevant to you',
                          style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 28,
                              fontFamily: 'Montserrat'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //color: Colors.red,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Divider(
                                color: Colors.white,
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 250, // Adjust the height as needed
                                child: ListView.builder(
                                  itemCount: 100, // Number of years to display
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final year = 1960 + index;
                                    return InkWell(
                                      onTap: () {
                                        print(year.toString());
                                        setState(() {
                                          yearGroup = year.toString();
                                        });
                                      },
                                      child: Container(
                                        height: 70,
                                        child: Column(
                                          children: [
                                            Text(
                                              year.toString(),
                                              style: TextStyle(
                                                color:
                                                    yearGroup == year.toString()
                                                        ? Colors.yellow
                                                        : Colors.white,
                                                fontSize:
                                                    yearGroup == year.toString()
                                                        ? 30
                                                        : 23,
                                                fontWeight:
                                                    yearGroup == year.toString()
                                                        ? FontWeight.bold
                                                        : FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 150,
                                              child: Divider(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                thickness: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                widget.data["year_group"] = yearGroup;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Register4(
                            data: widget.data,
                          )),
                );
              },
              child: Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: wesYellow),
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 15, color: wesGreen),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
