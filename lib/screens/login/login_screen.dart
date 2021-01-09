import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hack4environment/resources/c_colors.dart';
import 'package:hack4environment/resources/images.dart';
import 'package:hack4environment/resources/strings.dart';
import 'package:hack4environment/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameTextFieldController = TextEditingController();

  final passwordTextFieldController = TextEditingController();

  Color usernameTextFieldBorderColor = CColors.lightBlack;
  Color passwordTextFieldBorderColor = CColors.lightBlack;
  bool usernameWarningVisibility = false;
  bool passwordWarningVisibility = false;
  String warningMessage = Strings.loginEmptyField;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar:
        // AppBar(
        // leading: Image.asset(Images.appLogo),
        // title: Text(Strings.homeScreenAppBar),
        // ),
        body: Padding(
            padding: EdgeInsets.only(top: 60),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              Images.appLogo,
                              height: 150,
                              width: 150,
                            ),
                            Text(Strings.homeScreenAppBar,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CColors.lightBlack,
                                    fontSize: 25))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                        visible: usernameWarningVisibility,
                        child: Text(
                          warningMessage,
                          style: TextStyle(
                            fontSize: 16,
                            color: CColors.red,
                          ),
                        )),
                    Container(
                      child: TextField(
                        onTap: () {
                          setState(() {
                            usernameTextFieldBorderColor = CColors.lightBlack;
                            usernameWarningVisibility = false;
                          });
                        },
                        controller: usernameTextFieldController,
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintText: Strings.loginUsernameHint,
                          hintStyle: TextStyle(color: CColors.gray),
                          filled: true,
                          fillColor: CColors.darkWhite,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                            borderSide: BorderSide(
                                color: usernameTextFieldBorderColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: usernameTextFieldBorderColor, width: 3),
                          ),
                        ),
                      ),
                      width: 340,
                      padding: EdgeInsets.all(10.0),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Visibility(
                        visible: passwordWarningVisibility,
                        child: Text(warningMessage,
                            style: TextStyle(
                              fontSize: 16,
                              color: CColors.red,
                            ))),
                    Container(
                      child: TextField(
                        onTap: () {
                          setState(() {
                            passwordTextFieldBorderColor = CColors.lightBlack;
                            passwordWarningVisibility = false;
                          });
                        },
                        controller: passwordTextFieldController,
                        autocorrect: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: Strings.loginPasswordHint,
                          hintStyle: TextStyle(color: CColors.gray),
                          filled: true,
                          fillColor: CColors.darkWhite,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                            borderSide: BorderSide(
                                color: passwordTextFieldBorderColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: passwordTextFieldBorderColor, width: 3),
                          ),
                        ),
                      ),
                      width: 340,
                      padding: EdgeInsets.all(10.0),
                    ),

                    // TextField(
                    //   decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       hintText: 'Enter a search term'),
                    SizedBox(
                      height: 30,
                    ),
                    FlatButton(
                        height: 50,
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 44, right: 44),
                        hoverColor: CColors.vividGreen,
                        color: CColors.darkGreen,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 2, color: CColors.lightBlack),
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          String username = "User";
                          String password = "1234";

                          String usernameTextFieldText =
                              usernameTextFieldController.text;
                          String passwordTextFieldText =
                              passwordTextFieldController.text;

                          if (usernameTextFieldText.isEmpty ||
                              passwordTextFieldText.isEmpty) {
                            if (usernameTextFieldText.isEmpty) {
                              setState(() {
                                warningMessage = Strings.loginEmptyField;
                                usernameTextFieldBorderColor = CColors.red;
                                usernameWarningVisibility = true;
                              });
                            } if (passwordTextFieldText.isEmpty) {
                              setState(() {
                                warningMessage = Strings.loginEmptyField;
                                passwordTextFieldBorderColor = CColors.red;
                                passwordWarningVisibility = true;
                              });
                            }
                          } else {
                            if (username == usernameTextFieldText &&
                                password == passwordTextFieldText) {
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                              print("Logged in");
                            } else {
                              setState(() {
                                warningMessage =
                                    Strings.loginWrongUsernameOrPassword;
                                usernameWarningVisibility = true;
                              });
                            }
                          }
                        },
                        child: Text(
                          Strings.loginSignIn,
                          style: TextStyle(
                              fontSize: 30,
                              color: CColors.lightBlack,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 12,
                    ),
                    FlatButton(
                        height: 50,
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 40, right: 40),
                        hoverColor: CColors.vividGreen,
                        color: CColors.lightGreen,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 2, color: CColors.lightBlack),
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          print("Signing up");
                        },
                        child: Text(
                          Strings.loginSignUp,
                          style: TextStyle(
                              fontSize: 30,
                              color: CColors.lightBlack,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: 10),
                    GestureDetector(
                      child: Text(Strings.loginForgotPassword,
                          style: TextStyle(
                              color: CColors.lightBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      onTap: () => print("FORGOT PASSWORD"),
                    )
                  ],
                ),
              ),
            )));
  }
}
