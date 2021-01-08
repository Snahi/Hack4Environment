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
                        Image.asset(Images.cameraLogo,height: 100, width: 100,),
                          //
                          // size: 80,

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
                    Image.asset(Images.uploadLogo, height: 100, width: 100,),
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
