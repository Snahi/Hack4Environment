import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hack4environment/resources/c_colors.dart';
import 'package:hack4environment/resources/images.dart';
import 'package:hack4environment/resources/strings.dart';
import 'package:hack4environment/screens/take_photo/take_photo_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';

  List<RankUser> _topUsers = [];

  @override
  Widget build(BuildContext context) {
    _topUsers.add(RankUser("Majkel", 1, 150.0));
    _topUsers.add(RankUser("Snahi", 2, 140.0));
    _topUsers.add(RankUser("DzikiPaweł", 3, 125.0));
    _topUsers.add(RankUser("Staszkicjusz", 4, 100.0));
    _topUsers.add(RankUser("PanAdam", 5, 95.0));
    _topUsers.add(RankUser("CurrentUser", 40, 25.0));

    // Scaffold is a layout for the major Material Components.
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.homeScreenAppBar),
          leading: Image.asset(Images.appLogo),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      Strings.homeRankingTitle,
                      style: TextStyle(
                          color: CColors.lightBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Strings.homePosition,
                          style: TextStyle(
                              fontSize: 18, color: CColors.lightBlack),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          Strings.homeUsername,
                          style: TextStyle(
                              fontSize: 18, color: CColors.lightBlack),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          Strings.homePoints,
                          style: TextStyle(
                              fontSize: 18, color: CColors.lightBlack),
                        )
                      ],
                    ),
                    Container(
                      height: 280,
                      width: 300,
                      child: ListView(
                        padding: EdgeInsets.all(5),
                        children: [
                          _getListItemContainer(_topUsers[0]),
                          SizedBox(
                            height: 2,
                          ),
                          _getListItemContainer(_topUsers[1]),
                          SizedBox(
                            height: 2,
                          ),
                          _getListItemContainer(_topUsers[2]),
                          SizedBox(
                            height: 2,
                          ),
                          _getListItemContainer(_topUsers[3]),
                          SizedBox(
                            height: 2,
                          ),
                          _getListItemContainer(_topUsers[4]),
                          SizedBox(
                            height: 2,
                          ),
                          _getListItemContainer(_topUsers[5])
                        ],
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, TakePhotoScreen.routeName),
                          child: Column(
                            children: [
                              Image.asset(
                                Images.cameraLogo,
                                height: 100,
                                width: 100,
                              ),
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
                          Image.asset(
                            Images.uploadLogo,
                            height: 100,
                            width: 100,
                          ),
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
                      )
                    ]),
                  ],
                )
              ],
            )));
  }

  Widget _getListItemContainer(RankUser rankUser) {
    Color itemColor = CColors.lightGreen;

    if (rankUser._user == "CurrentUser") {
      itemColor = CColors.darkGreen;
    }

    return Container(
      height: 40,
      width: 300,
      decoration: BoxDecoration(
        color: itemColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
              width: 30,
              alignment: Alignment.center,
              child: Text(
                rankUser._rankPos.toString(),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CColors.lightBlack),
              )),
          SizedBox(
            width: 60,
          ),
          Expanded(
              child: Text(
            rankUser._user,
            style: TextStyle(
              color: CColors.lightBlack,
              fontSize: 16,
            ),
          )),
          SizedBox(
            width: 20,
          ),
          Container(
              width: 60,
              alignment: Alignment.center,
              child: Text(
                rankUser._points.toString(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: CColors.lightBlack),
              ))
        ],
      ),
    );
  }
}

class RankUser {
  String _user;
  int _rankPos;
  double _points;

  String get user => _user;

  int get rankPos => _rankPos;

  double get points => _points;

  RankUser(this._user, this._rankPos, this._points);
}
