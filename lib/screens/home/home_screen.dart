import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hack4environment/resources/images.dart';
import 'package:hack4environment/resources/strings.dart';
import 'package:hack4environment/screens/take_photo/take_photo_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.homeScreenAppBar),
          leading: Image.asset(Images.appLogo),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () => Navigator.pushNamed(context, TakePhotoScreen.routeName),
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.lightGreen[800],
                          size: 80,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Center(
                            child: Text(Strings.homeTakePhoto,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)))
                      ],
                    )),
                SizedBox(
                  width: 50,
                ),
                Column(
                  children: [
                    Icon(Icons.add_photo_alternate_rounded,
                        color: Colors.lightGreen[800], size: 80),
                    SizedBox(
                      height: 6,
                    ),
                    Center(
                        child: Text(Strings.homeUploadPhoto,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
