import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hack4environment/resources/c_colors.dart';
import 'package:hack4environment/resources/images.dart';
import 'package:hack4environment/resources/strings.dart';
import 'package:hack4environment/screens/home/home_screen.dart';
import 'package:hack4environment/screens/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameTextFieldController = TextEditingController();

  final _passwordTextFieldController = TextEditingController();

  Color _usernameTextFieldBorderColor = CColors.lightBlack;
  Color _passwordTextFieldBorderColor = CColors.lightBlack;
  bool _usernameWarningVisibility = false;
  bool _passwordWarningVisibility = false;
  String _warningMessage = Strings.loginEmptyField;

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
                        visible: _usernameWarningVisibility,
                        child: Text(
                          _warningMessage,
                          style: TextStyle(
                            fontSize: 16,
                            color: CColors.red,
                          ),
                        )),
                    Container(
                      child: TextField(
                        onTap: () {
                          setState(() {
                            _usernameTextFieldBorderColor = CColors.lightBlack;
                            _usernameWarningVisibility = false;
                          });
                        },
                        controller: _usernameTextFieldController,
                        autocorrect: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                             color: CColors.darkPurple
                          ),
                          hintText: Strings.loginUsernameHint,
                          hintStyle: TextStyle(color: CColors.gray),
                          filled: true,
                          fillColor: CColors.darkWhite,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                            borderSide: BorderSide(
                                color: _usernameTextFieldBorderColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: _usernameTextFieldBorderColor, width: 3),
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
                        visible: _passwordWarningVisibility,
                        child: Text(_warningMessage,
                            style: TextStyle(
                              fontSize: 16,
                              color: CColors.red,
                            ))),
                    Container(
                      child: TextField(
                        onTap: () {
                          setState(() {
                            _passwordTextFieldBorderColor = CColors.lightBlack;
                            _passwordWarningVisibility = false;
                          });
                        },
                        controller: _passwordTextFieldController,
                        autocorrect: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                              Icons.vpn_key_rounded,
                              color: CColors.darkPurple
                          ),
                          hintText: Strings.loginPasswordHint,
                          hintStyle: TextStyle(color: CColors.gray),
                          filled: true,
                          fillColor: CColors.darkWhite,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                            borderSide: BorderSide(
                                color: _passwordTextFieldBorderColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: _passwordTextFieldBorderColor, width: 3),
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
                              _usernameTextFieldController.text;
                          String passwordTextFieldText =
                              _passwordTextFieldController.text;

                          if (usernameTextFieldText.isEmpty ||
                              passwordTextFieldText.isEmpty) {
                            if (usernameTextFieldText.isEmpty) {
                              setState(() {
                                _warningMessage = Strings.loginEmptyField;
                                _usernameTextFieldBorderColor = CColors.red;
                                _usernameWarningVisibility = true;
                              });
                            } if (passwordTextFieldText.isEmpty) {
                              setState(() {
                                _warningMessage = Strings.loginEmptyField;
                                _passwordTextFieldBorderColor = CColors.red;
                                _passwordWarningVisibility = true;
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
                                _warningMessage =
                                    Strings.loginWrongUsernameOrPassword;
                                _usernameWarningVisibility = true;
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
                          Navigator.pushNamed(context, SignUpScreen.routeName);
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
