import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack4environment/resources/c_colors.dart';
import 'package:hack4environment/resources/images.dart';
import 'package:hack4environment/resources/strings.dart';
import 'package:hack4environment/screens/login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "SignupScreen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameTextFieldController = TextEditingController();
  TextEditingController _passwordTextFieldController = TextEditingController();
  TextEditingController _repeatPasswordTextFieldController =
  TextEditingController();
  TextEditingController _emailTextFieldController = TextEditingController();

  Color _usernameTextFieldBorderColor = CColors.lightBlack;
  Color _passwordTextFieldBorderColor = CColors.lightBlack;
  Color _repeatPasswordTextFieldBorderColor = CColors.lightBlack;
  Color _emailTextFieldBorderColor = CColors.lightBlack;
  String _usernameWarning = Strings.loginEmptyField;
  String _passwordsWarning = Strings.loginEmptyField;
  String _emailWarning = Strings.loginEmptyField;
  bool _usernameWarningVisibility = false;
  bool _passwordWarningVisibility = false;
  bool _repeatPasswordWarningVisibility = false;
  bool _emailWarningVisibility = false;

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
                    child: Column(children: [

                      Text(
                        Strings.appName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: CColors.lightBlack),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Image.asset(
                                    Images.appLogo,
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(Strings.signUpText,
                                      style: TextStyle(
                                        color: CColors.lightBlack,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ])
                          ]),

                      SizedBox(
                        height: 18,
                      ),

                      Visibility(

                        visible: _usernameWarningVisibility,
                        child: Text(
                          _usernameWarning,
                          style: TextStyle(
                            color: CColors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      Container(
                        child: TextField(
                          onTap: () {
                            setState(() {
                              _usernameTextFieldBorderColor = CColors
                                  .lightBlack;
                              _usernameWarningVisibility = false;
                            });
                          },
                          controller: _usernameTextFieldController,
                          autocorrect: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                                Icons.person, color: CColors.darkPurple),
                            hintText: Strings.loginUsernameHint,
                            hintStyle: TextStyle(color: CColors.gray),
                            filled: true,
                            fillColor: CColors.darkWhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  18.0)),
                              borderSide: BorderSide(
                                  color: _usernameTextFieldBorderColor,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)),
                              borderSide: BorderSide(
                                  color: _usernameTextFieldBorderColor,
                                  width: 3),
                            ),
                          ),
                        ),
                        width: 340,
                        padding: EdgeInsets.all(10.0),
                      ),

                      Visibility(
                        visible: _emailWarningVisibility,
                        child: Text(_emailWarning,
                            style: TextStyle(
                              color: CColors.red,
                              fontSize: 16,
                            )),
                      ),
                      Container(
                        child: TextField(
                          onTap: () {
                            setState(() {
                              _emailWarningVisibility = false;
                              _emailTextFieldBorderColor = CColors.lightBlack;
                            });

                          },
                          controller: _emailTextFieldController,
                          autocorrect: true,
                          decoration: InputDecoration(
                            prefixIcon:
                            Icon(Icons.mail_rounded, color: CColors.darkPurple),
                            hintText: Strings.signUpEmailHintText,
                            hintStyle: TextStyle(color: CColors.gray),
                            filled: true,
                            fillColor: CColors.darkWhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  18.0)),
                              borderSide: BorderSide(
                                  color: _emailTextFieldBorderColor,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)),
                              borderSide: BorderSide(
                                  color: _emailTextFieldBorderColor,
                                  width: 3),
                            ),
                          ),
                        ),
                        width: 340,
                        padding: EdgeInsets.all(10.0),
                      ),
                      Visibility(
                          visible: _passwordWarningVisibility,
                          child: Text(_passwordsWarning,
                              style: TextStyle(
                                fontSize: 16,
                                color: CColors.red,
                              ))),
                      Container(
                        child: TextField(
                          onTap: () {
                            setState(() {
                              _passwordTextFieldBorderColor = CColors
                                  .lightBlack;
                              _passwordWarningVisibility = false;
                            });
                          },
                          controller: _passwordTextFieldController,
                          autocorrect: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon:
                            Icon(Icons.vpn_key_rounded,
                                color: CColors.darkPurple),
                            hintText: Strings.loginPasswordHint,
                            hintStyle: TextStyle(color: CColors.gray),
                            filled: true,
                            fillColor: CColors.darkWhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  18.0)),
                              borderSide: BorderSide(
                                  color: _passwordTextFieldBorderColor,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)),
                              borderSide: BorderSide(
                                  color: _passwordTextFieldBorderColor,
                                  width: 3),
                            ),
                          ),
                        ),
                        width: 340,
                        padding: EdgeInsets.all(10.0),
                      ),
                      Visibility(
                          visible: _repeatPasswordWarningVisibility,
                          child: Text(_passwordsWarning,
                              style: TextStyle(
                                fontSize: 16,
                                color: CColors.red,
                              ))),
                      Container(
                        child: TextField(
                          onTap: () {
                            setState(() {
                              _repeatPasswordTextFieldBorderColor = CColors
                                  .lightBlack;
                              _repeatPasswordWarningVisibility = false;
                            });
                          },
                          controller: _repeatPasswordTextFieldController,
                          autocorrect: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon:
                            Icon(Icons.vpn_key_rounded,
                                color: CColors.darkPurple),
                            hintText: Strings.signUpRepeatPasswordHintText,
                            hintStyle: TextStyle(color: CColors.gray),
                            filled: true,
                            fillColor: CColors.darkWhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  18.0)),
                              borderSide: BorderSide(
                                  color: _repeatPasswordTextFieldBorderColor,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)),
                              borderSide: BorderSide(
                                  color: _repeatPasswordTextFieldBorderColor,
                                  width: 3),
                            ),
                          ),
                        ),
                        width: 340,
                        padding: EdgeInsets.all(10.0),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                          height: 50,
                          padding:
                          EdgeInsets.only(
                              top: 8, bottom: 8, left: 44, right: 44),
                          hoverColor: CColors.vividGreen,
                          color: CColors.lightGreen,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 2, color: CColors.lightBlack),
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            String username = _usernameTextFieldController.text;
                            String email = _emailTextFieldController.text;
                            String password = _passwordTextFieldController.text;
                            String password2 = _repeatPasswordTextFieldController
                                .text;

                            if (username.isEmpty) {
                              setState(() {
                                _usernameWarningVisibility = true;
                                _usernameTextFieldBorderColor = CColors.red;
                                // _usernameWarning = Strings.loginEmptyField;
                              });

                            }

                            if (email.isEmpty) {
                              setState(() {
                                _emailTextFieldBorderColor = CColors.red;
                                _emailWarningVisibility = true;
                              });
                            }

                            if(password.isEmpty) {
                              setState(() {
                                _passwordWarningVisibility = true;
                                _passwordTextFieldBorderColor = CColors.red;
                              });
                            }

                            if(password2.isEmpty) {
                              setState(() {
                                _repeatPasswordWarningVisibility = true;
                                _repeatPasswordTextFieldBorderColor = CColors.red;
                              });
                            }

                            // /TODO
                            // check if username exists
                          },
                          child: Text(
                            Strings.loginSignIn,
                            style: TextStyle(
                                fontSize: 30,
                                color: CColors.lightBlack,
                                fontWeight: FontWeight.bold),
                          )),

                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                          height: 50,
                          padding:
                          EdgeInsets.only(
                              top: 8, bottom: 8, left: 58, right: 58),
                          hoverColor: CColors.vividGreen,
                          color: CColors.darkGreen,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 2, color: CColors.lightBlack),
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            Strings.signUpGoBackText,
                            style: TextStyle(
                                fontSize: 30,
                                color: CColors.lightBlack,
                                fontWeight: FontWeight.bold),
                          )),
                    ])))));
  }
}
