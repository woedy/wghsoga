import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wghsoga_app/Auth/UpdateProfile/UpdateMoreInfo.dart';
import 'package:wghsoga_app/constants.dart';

class UpdateInterests extends StatefulWidget {
  final data;
  final update_data;
  const UpdateInterests(
      {super.key, required this.data, required this.update_data});

  @override
  State<UpdateInterests> createState() => _UpdateInterestsState();
}

class _UpdateInterestsState extends State<UpdateInterests> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _interestController = TextEditingController();

  final List<String> interests = [];
  String newInterest = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: const DecorationImage(
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
                  const Image(
                      height: 50,
                      image: AssetImage('assets/images/geyhey_logo.png'))
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome',
                              style: TextStyle(
                                  height: 1,
                                  color: wesWhite,
                                  fontSize: 28,
                                  fontFamily: 'Montserrat'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.data['first_name'],
                              style: const TextStyle(
                                  height: 1,
                                  color: wesWhite,
                                  fontSize: 62,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'What are your passions?',
                              style: TextStyle(
                                  height: 1.2,
                                  color: wesWhite,
                                  fontSize: 20,
                                  fontFamily: 'Montserrat'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15)),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.1),
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller:
                                            _interestController, // Assign the controller

                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          labelText: "Add Interest",
                                          labelStyle: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(225),
                                        ],

                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Interest is required';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          if (value != null) {
                                            interests.add(value);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        setState(() {
                                          _interestController
                                              .clear(); // Clear the input field
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: wesYellow,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            blurRadius: 2,
                                            offset: const Offset(
                                                2, 4), // Shadow position
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          color: wesGreen,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Wrap(
                                  spacing: 8, // Space between each container
                                  runSpacing:
                                      8, // Space between each line of containers
                                  children:
                                      List.generate(interests.length, (index) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .yellow, // Replace with wesYellow
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 2,
                                            offset: const Offset(
                                                2, 4), // Shadow position
                                          ),
                                        ],
                                      ),
                                      child: IntrinsicWidth(
                                        child: IntrinsicHeight(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Center(
                                                child: Text(
                                                  interests[index],
                                                  style: const TextStyle(
                                                      color: Colors
                                                          .green), // Replace with wesGreen
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    interests.removeAt(index);
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateMoreInfo(
                                data: widget.data,
                                update_data: widget.update_data,
                              )),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: const Center(
                      child: Text(
                        'Skip',
                        style: TextStyle(fontSize: 15, color: wesWhite),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (interests.isNotEmpty) {
                      widget.update_data['interests'] = interests;
                      print(widget.update_data);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateMoreInfo(
                                  data: widget.data,
                                  update_data: widget.update_data,
                                )),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: wesYellow),
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(fontSize: 15, color: wesGreen),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
