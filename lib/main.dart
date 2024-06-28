
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wghsoga_app/Auth/Register/Regsiter4.dart';
import 'package:wghsoga_app/Auth/SignIn/sign_up_screen.dart';
import 'package:wghsoga_app/Auth/UpdateProfile/UpdateBio.dart';
import 'package:wghsoga_app/Auth/UpdateProfile/UpdateInterests.dart';
import 'package:wghsoga_app/Auth/UpdateProfile/UpdatePhoto.dart';
import 'package:wghsoga_app/Onboarding/onboarding.dart';
import 'package:wghsoga_app/theme.dart';

import 'Auth/Register/Regsiter1.dart';
import 'Auth/Register/Regsiter2.dart';
import 'Auth/Register/Regsiter3.dart';
import 'Auth/Register/VerifyEmail.dart';
import 'Auth/UpdateProfile/UpdateMoreInfo.dart';
import 'Auth/UpdateProfile/UpdateOption.dart';
import 'Auth/UpdateProfile/UpdateSocialMedia.dart';
import 'Auth/UpdateProfile/UpdateSummary.dart';
import 'Homepage/Homepage.dart';
import 'SplashScreen/spalsh_screen.dart';
import 'constants.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => {runApp(MyApp())});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide the keyboard when tapping outside the text field
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WGHSOGA',
        theme: theme(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? api_key = "";
  Future? _user_api;

  @override
  void initState() {
    super.initState();
    _user_api = apiKey();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _user_api,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          return  HomepageScreen();
          //return api_key == null ? SplashScreen() : HomeScreen();
          //return ServiceDetails(service_id: 'SER-2342',service_name: "Welo Bello", service_rating: "4.8", shop_location: "Accra", open: true, service_price: "\$ 2,345", service_photo: "null",);

        });
  }

  Future apiKey() async {
    api_key = await getApiPref();
  }
}
