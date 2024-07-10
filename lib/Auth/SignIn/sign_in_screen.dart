
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wghsoga_app/Components/error_dialog.dart';
import 'package:wghsoga_app/Components/keyboard_utils.dart';
import 'package:wghsoga_app/Components/loading_dialog.dart';
import 'package:wghsoga_app/Components/sucess_dialog.dart';
import 'package:wghsoga_app/Homepage/Homepage.dart';
import 'package:wghsoga_app/constants.dart';
import 'package:http/http.dart' as http;

import 'models/sign_in_model.dart';



Future<SignInModel> signInUser(String email, String password) async {

  final response = await http.post(
    Uri.parse(hostName + "api/accounts/login-user/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    },
    body: jsonEncode({
      "email": email,
      "password": password,
      "fcm_token": "dsfsdfdsfsdfds",
    }),
  );


  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    final result = json.decode(response.body);
    if (result != null) {
      print(result['data']['token'].toString());

      await saveIDApiKey(result['data']['token'].toString());
      await saveUserID(result['data']['user_id'].toString());


      await saveUserData(result['data']);


    }
    return SignInModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 422) {
    print(jsonDecode(response.body));
    return SignInModel.fromJson(jsonDecode(response.body));
  }  else if (response.statusCode == 403) {
    print(jsonDecode(response.body));
    return SignInModel.fromJson(jsonDecode(response.body));
  }   else if (response.statusCode == 400) {
    print(jsonDecode(response.body));
    return SignInModel.fromJson(jsonDecode(response.body));
  }  else {

    throw Exception('Failed to Sign In');
  }
}


Future<bool> saveIDApiKey(String apiKey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("API_Key", apiKey);
  return prefs.commit();
}

Future<bool> saveUserID(String apiKey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("USER_ID", apiKey);
  return prefs.commit();
}


Future<void> saveUserData(Map<String, dynamic> userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user_data', json.encode(userData));
}


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();


  String? email;
  String? password;

  var show_password = false;

  Future<SignInModel>? _futureSignIn;


  @override
  Widget build(BuildContext context) {
    return (_futureSignIn == null) ? buildColumn() : buildFutureBuilder();
  }






  buildColumn() {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/wes_back.png'),
                  fit: BoxFit.cover
              )
          ),
          child: SafeArea(

            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image(
                        height: 50,
                        image: AssetImage('assets/images/geyhey_logo.png'))
                  ],
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
                            Text('Login', style: TextStyle(height:1, color: wesWhite, fontSize: 62, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),),

                            SizedBox(
                              height: 50,
                            ),
                            Text('Welcome Back', style: TextStyle(height:1, color: wesWhite, fontSize: 28, fontFamily: 'Montserrat'),),
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
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child:    Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
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
                                    labelText: "Email",
                                    labelStyle:
                                    TextStyle(fontSize: 13, color: bodyText2),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: wesWhite)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: wesWhite)),
                                    border: InputBorder.none,),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(225),
                                    PasteTextInputFormatter(),
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email is required';
                                    }
                                    if (value.length < 3) {
                                      return 'Name too short';
                                    }
                                    String pattern =
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                        r"{0,253}[a-zA-Z0-9])?)*$";
                                    RegExp regex = RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Enter a valid email address';

                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  onSaved: (value) {
                                    setState(() {
                                      email = value!.toLowerCase();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  //color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.1))),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    //hintText: 'Enter Password',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            show_password = !show_password;
                                          });
                                        },
                                        icon: Icon(
                                          show_password
                                              ? Icons.remove_red_eye_outlined
                                              : Icons.remove_red_eye,
                                          color: Colors.white,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                      labelText: "Password",
                                      labelStyle:
                                      TextStyle(fontSize: 13, color: bodyText2),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: wesWhite)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: wesWhite)),
                                      border: InputBorder.none),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(225),
                                    PasteTextInputFormatter(),
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password is required';
                                    }
                                    if (value.length < 5) {
                                      return 'Password too short';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  obscureText: show_password ? false : true,
                                  onSaved: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 60,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Forgot Password?', style: TextStyle(height:1, color: wesWhite, fontSize: 15, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),

                          SizedBox(
                            height: 60,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don’t have an account?', style: TextStyle(height:1, color: wesWhite, fontSize: 15, fontFamily: 'Montserrat',),),

                              SizedBox(
                                height: 30,
                              ),

                              Text(' Sign Up', style: TextStyle(height:1, color: wesYellow, fontSize: 15, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ],
                      ),


                    ],
                  ),
                ),


                InkWell(
                  onTap: (){
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      KeyboardUtil.hideKeyboard(context);

                      print("#################################################");
                      print("#################################################");
                      print(email);
                      print(password);

                     _futureSignIn = signInUser(email!, password!);
                      //_futureSignIn = signInUser(user!, password!, platformType!);


                    }

                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: wesYellow
                    ),
                    child: Center(
                      child: Text('Login', style: TextStyle(fontSize: 15, color: wesGreen),),
                    ),
                  ),
                )

              ],
            ),
          ),
        )
    );
  }



  FutureBuilder<SignInModel> buildFutureBuilder() {
    return FutureBuilder<SignInModel>(
        future: _futureSignIn,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingDialogBox(text: 'Please Wait..',);
          }
          else if(snapshot.hasData) {

            var data = snapshot.data!;

            print("#########################");
            //print(data.data!.token!);

            if(data.message == "Successful") {

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomepageScreen()),
                );

                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      // Show the dialog
                      return SuccessDialogBox(text: "Login Successful");
                    }
                );
              });


            }

            else if (data.message == "Errors") {
              String? errorKey = snapshot.data!.errors!.keys.firstWhere(
                    (key) => key == "password" || key == "email",
                orElse: () => null!,
              );
              if (errorKey != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInScreen())
                  );

                  String customErrorMessage = snapshot.data!.errors![errorKey]![0];
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context){
                        return ErrorDialogBox(text: customErrorMessage);
                      }
                  );

                });
              }
            }



          }

          return LoadingDialogBox(text: 'Please Wait..',);


        }
    );
  }


  void dispose() {
    super.dispose();
  }

}
