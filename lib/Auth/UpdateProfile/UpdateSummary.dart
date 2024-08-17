import 'package:flutter/material.dart';
import 'package:wghsoga_app/Auth/UpdateProfile/UpdateSuccess.dart';
import 'package:wghsoga_app/Auth/UpdateProfile/models/UpdateProfile.dart';
import 'package:wghsoga_app/Components/error_dialog.dart';
import 'package:wghsoga_app/Components/loading_dialog.dart';
import 'package:wghsoga_app/Homepage/Homepage.dart';
import 'package:wghsoga_app/constants.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';

Future<UpdateProfileModel> update_profile(data) async {
  var token = await getApiPref();
  var userId = await getUserIDPref();
  var uri = Uri.parse(hostName + "/api/accounts/update-user-info/");

  // Create a multipart request
  var request = http.MultipartRequest('POST', uri);

  // Add headers
  request.headers.addAll({
    // 'Authorization': 'Token $token', // Use your actual token here
    'Authorization':
        'Token 080a263af80fbfed5c4def6ec747b2972440315c', //+ token.toString()
  });

  print('###################################');
  print(data['bio']);

  // Add fields
  request.fields['user_id'] = '09ta2sse4w09eztznr0bso91h8qivxajddf1xfl2l54hk';
  request.fields['bio'] = data['bio'] ?? "";



   
  // Serialize the list of interests
  if (data['interests'] != null && data['interests'] is List<String>) {
    request.fields['interests'] = jsonEncode(data['interests']);
  } else {
    request.fields['interests'] = jsonEncode([]);
  }

  request.fields['job_title'] = data['job_title'] ?? "";
  request.fields['place_of_work'] = data['place_of_work'] ?? "";
  request.fields['house'] = data['house'] ?? "";
  request.fields['city'] = data['city'] ?? "";
  request.fields['website'] = data['website'] ?? "";
  request.fields['linked_in'] = data['linked_in'] ?? "";
  request.fields['instagram'] = data['instagram'] ?? "";
  request.fields['facebook'] = data['facebook'] ?? "";
  request.fields['twitter'] = data['twitter'] ?? "";

  if (data['photos'] != null) {
    // Add files
    for (var photo in data['photos']) {
      request.files.add(
        http.MultipartFile(
          'photos', // Field name, must match the server expectation
          photo.readAsBytes().asStream(),
          photo.lengthSync(),
          filename: photo.uri.pathSegments.last,
          contentType: MediaType(
              'image', 'jpeg'), // Adjust the type according to your file format
        ),
      );
    }
  }
  // Send the request
  var response = await request.send();

  // Get the response
  final responseBody = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    print(responseBody);
    return UpdateProfileModel.fromJson(jsonDecode(responseBody));
  } else if (response.statusCode == 422 ||
      response.statusCode == 403 ||
      response.statusCode == 400) {
    print(responseBody);
    return UpdateProfileModel.fromJson(jsonDecode(responseBody));
  } else {
    throw Exception('Failed to update data');
  }
}

class UpdateSummary extends StatefulWidget {
  final data;
  final update_data;
  const UpdateSummary(
      {super.key, required this.data, required this.update_data});

  @override
  State<UpdateSummary> createState() => _UpdateSummaryState();
}

class _UpdateSummaryState extends State<UpdateSummary> {
  Future<UpdateProfileModel>? _futureUpdateProfile;

  @override
  Widget build(BuildContext context) {
    return (_futureUpdateProfile == null)
        ? buildColumn()
        : buildFutureBuilder();
  }

  buildColumn() {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'We are all set',
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
                          widget.data['first_name'] ?? "",
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //color: Colors.red,
                      //padding: EdgeInsets.only(top: 100), // Adjust the top padding to create space
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(
                                top: 90, left: 20, right: 20, bottom: 0),
                            height: MediaQuery.of(context).size.height -
                                100, // Adjust the height to account for the top padding
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
                                    Column(
                                      children: [
                                        Text(
                                          "${widget.data['first_name'] ?? ""} ${widget.data['middle_name'] ?? ""} ${widget.data['last_name'] ?? ""}",
                                          style: const TextStyle(
                                              height: 1,
                                              color: wesWhite,
                                              fontSize: 26,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.data['email'] ?? "",
                                          style: const TextStyle(
                                              height: 1,
                                              color: wesWhite,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.data['year_group'] ?? "",
                                          style: const TextStyle(
                                              height: 1,
                                              color: wesWhite,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.update_data['house'] ?? "",
                                          style: const TextStyle(
                                              height: 1,
                                              color: wesWhite,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Bio',
                                            style: TextStyle(
                                                height: 1,
                                                color: wesYellow,
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            widget.update_data['bio'] ?? "",
                                            style: const TextStyle(
                                                height: 1,
                                                color: wesWhite,
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Interests',
                                            style: TextStyle(
                                                height: 1,
                                                color: wesYellow,
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          if (widget.update_data['interests'] !=
                                              null) ...[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Wrap(
                                                spacing:
                                                    8, // Space between each container
                                                runSpacing:
                                                    8, // Space between each line of containers
                                                children: List.generate(
                                                    widget
                                                        .update_data[
                                                            'interests']
                                                        .length, (index) {
                                                  return Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .yellow, // Replace with wesYellow
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.1),
                                                          blurRadius: 2,
                                                          offset: const Offset(
                                                              2,
                                                              4), // Shadow position
                                                        ),
                                                      ],
                                                    ),
                                                    child: IntrinsicWidth(
                                                      child: IntrinsicHeight(
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                widget.update_data[
                                                                        'interests']
                                                                    [index],
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .green), // Replace with wesGreen
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
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'General',
                                          style: TextStyle(
                                              height: 1,
                                              color: wesYellow,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: Text(
                                              'Profession',
                                              style: TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600),
                                            )),
                                            Expanded(
                                                child: Text(
                                              widget.update_data[
                                                      'profession'] ??
                                                  "",
                                              style: const TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w300),
                                            )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: Text(
                                              'Job Title',
                                              style: TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600),
                                            )),
                                            Expanded(
                                                child: Text(
                                              widget.update_data['job_title'] ??
                                                  "",
                                              style: const TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w300),
                                            )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: Text(
                                              'Place Of Work',
                                              style: TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600),
                                            )),
                                            Expanded(
                                                child: Text(
                                              widget.update_data[
                                                      'place_of_work'] ??
                                                  "",
                                              style: const TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w300),
                                            )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: Text(
                                              'City',
                                              style: TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600),
                                            )),
                                            Expanded(
                                                child: Text(
                                              widget.update_data['city'] ?? "",
                                              style: const TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w300),
                                            )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: Text(
                                              'House',
                                              style: TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600),
                                            )),
                                            Expanded(
                                                child: Text(
                                              widget.update_data['house'] ?? "",
                                              style: const TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w300),
                                            )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Social Media',
                                          style: TextStyle(
                                              height: 1,
                                              color: wesYellow,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                  'assets/icons/web.png'),
                                              height: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              widget.update_data['website'] ??
                                                  "",
                                              style: const TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                  'assets/icons/linkedin.png'),
                                              height: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              widget.update_data['linkedin'] ??
                                                  "",
                                              style: const TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                  'assets/icons/insta.png'),
                                              height: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              widget.update_data['instagram'] ??
                                                  "",
                                              style: const TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                  'assets/icons/facebook.png'),
                                              height: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              widget.update_data['facebook'] ??
                                                  "",
                                              style: const TextStyle(
                                                  height: 1,
                                                  color: wesWhite,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                    if (widget.update_data['photos'] != null)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 100,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: widget
                                                    .update_data['photos']
                                                    .length,
                                                itemBuilder: (contex, index) {
                                                  return Container(
                                                    height: 100,
                                                    width: 100,
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: FileImage(
                                                                widget.update_data[
                                                                        'photos']
                                                                    [index]),
                                                            fit: BoxFit.cover),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                        ],
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
                                                offset: const Offset(
                                                    2, 4), // Shadow position
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          left: 7.5,
                                          right: 7.5,
                                          child: Column(
                                            children: [
                                              if (widget
                                                      .update_data['photos'] !=
                                                  null) ...[
                                                Container(
                                                  height: 145,
                                                  width: 145,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                          widget.update_data[
                                                              'photos'][0]),
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
                                              ] else ...[
                                                Container(
                                                  height: 145,
                                                  width: 145,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    image:
                                                        const DecorationImage(
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
                                              ]
                                            ],
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
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _futureUpdateProfile = update_profile(widget.update_data);
                  print('#############################');
                  print(widget.update_data);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: wesYellow),
                child: const Center(
                  child: Text(
                    'Save and proceed',
                    style: TextStyle(fontSize: 15, color: wesGreen),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  FutureBuilder<UpdateProfileModel> buildFutureBuilder() {
    return FutureBuilder<UpdateProfileModel>(
        future: _futureUpdateProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingDialogBox(
              text: 'Please Wait..',
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;

            print("#########################");

            if (data.message == "Successful") {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateSuccess(data:widget.data)),
                  (route) => false, // Remove all previous routes
                );

                /*         showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      // Show the dialog
                      return SuccessDialogBox(text: " Successful");
                    }); */
              });
            } else if (data.message == "Errors") {
              String? errorKey = snapshot.data!.errors!.keys.firstWhere(
                (key) => key == "user_id",
                orElse: () => null!,
              );
              if (errorKey != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateSummary(
                                data: widget.data,
                                update_data: widget.update_data,
                              )));

                  String customErrorMessage =
                      snapshot.data!.errors![errorKey]![0];
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return ErrorDialogBox(text: customErrorMessage);
                      });
                });
              }
            }
          }

          return const LoadingDialogBox(
            text: 'Please Wait..',
          );
        });
  }
}
