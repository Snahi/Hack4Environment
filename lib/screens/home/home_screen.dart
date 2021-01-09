import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hack4environment/models/challenge.dart';
import 'package:hack4environment/resources/api.dart';
import 'package:hack4environment/resources/c_colors.dart';
import 'package:hack4environment/resources/images.dart';
import 'package:hack4environment/resources/strings.dart';
import 'package:hack4environment/screens/challenge/challenge_screen.dart';
import 'package:hack4environment/screens/labelling/labelling_screen.dart';
import 'package:hack4environment/services/users_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

// <a href='https://www.freepik.com/vectors/people'>People vector created by pch.vector - www.freepik.com</a>

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RankUser> _topUsers = [];
  String _selectedTop = Strings.topUsers[1];

  @override
  Widget build(BuildContext context) {
    _topUsers.add(RankUser("Majkel", 1, 150.0));
    _topUsers.add(RankUser("Snahi", 2, 140.0));
    _topUsers.add(RankUser("DzikiPaweł", 3, 125.0));
    _topUsers.add(RankUser("Staszkicjusz", 4, 100.0));
    _topUsers.add(RankUser("PanAdam", 5, 95.0));
    _topUsers.add(RankUser("CurrentUser", 40, 25.0));
    _showChallenges();
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
                    Row(children: [
                      SizedBox(width: 90),
                      Text(
                        Strings.homeRankingTitle,
                        style: TextStyle(
                            color: CColors.lightBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(width: 50, child: _buildTopDropdown()),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                          child: Icon(Icons.refresh_rounded,
                              color: CColors.darkGreen, size: 20),
                          onTap: () {
                            updateRanking();
                          }),
                    ]),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Strings.homePosition,
                          style: TextStyle(
                              fontSize: 16, color: CColors.lightBlack),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          Strings.homeUsername,
                          style: TextStyle(
                              fontSize: 16, color: CColors.lightBlack),
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Text(
                          Strings.homePoints,
                          style: TextStyle(
                              fontSize: 16, color: CColors.lightBlack),
                        )
                      ],
                    ),
                    Container(
                      height: 240,
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
                          onTap: () {
                            _pickFromCamera(context);
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                Images.cameraLogo,
                                height: 90,
                                width: 90,
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
                      GestureDetector(
                        onTap: () {
                          _pickFromGallery(context);
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              Images.galleryLogo,
                              height: 90,
                              width: 90,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Center(
                                child: Text(Strings.homeMyPhotos,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ChallengeScreen.routeName);
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              Images.trophyLogo,
                              height: 80,
                              width: 80,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Center(
                                child: Text(Strings.homeChallenge,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)))
                          ],
                        ),
                      )
                    ]),
                  ],
                )
              ],
            )));
  }

  void _pickFromGallery(BuildContext context) async {
    try {
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
      String imgPath = pickedFile.path;
      Navigator.pushNamed(context, LabellingScreen.routeName,
          arguments: LabellingScreenArgs(imgPath: imgPath));
    } catch (e) {
      print(e);
    }
  }

  void _pickFromCamera(BuildContext context) async {
    try {
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.camera);
      String imgPath = pickedFile.path;
      Navigator.pushNamed(context, LabellingScreen.routeName,
          arguments: LabellingScreenArgs(imgPath: imgPath));
    } catch (e) {
      print(e);
    }
  }

  Widget _getListItemContainer(RankUser rankUser) {
    Color itemColor = CColors.lightGreen;

    if (rankUser._user == "CurrentUser") {
      itemColor = CColors.darkGreen;
    }

    return Container(
      height: 30,
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
                    fontSize: 16,
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
              fontSize: 14,
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: CColors.lightBlack),
              )),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  Widget _buildTopDropdown() => DropdownButton<String>(
        value: _selectedTop,
        isExpanded: true,
        items: Strings.topUsers.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedTop = newValue;
          });
        },
      );

  updateRanking() async {
    Dio dio = Dio();
    _topUsers = new List();
    try {
      var response = await dio.get(Api.urlRanking + 5.toString());

      print(response);
    } catch (e) {
      print(e);
    }
  }

  void _showChallenges() async {
    String username = _getCurrentUserUsername();
    List<Challenge> challenges =
        await UsersRepository().getChallenges(username);

    _showChallengeDialog(challenges, username);
  }

  void _showChallengeDialog(List<Challenge> challenges, String username) {
    if (challenges.isNotEmpty) {
      Challenge current = challenges.removeLast();
      showDialog(
          context: context,
          builder: (_) => AssetGiffyDialog(
                image: Image.asset(Images.compete),
                title: Text(
                  current.senderUsername + ' challenges you!',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                description: Text(
                    'The competition starts today. Take as many good pictures as possible in the nearest ${current.days} days.'),
                entryAnimation: EntryAnimation.DEFAULT,
                onOkButtonPressed: () {
                  if (challenges.isNotEmpty) {
                    _acceptChallenge(current, username);
                    Navigator.pop(context);
                    _showChallengeDialog(challenges, username);
                  } else {
                    Navigator.pop(context);
                  }
                },
                onCancelButtonPressed: () {
                  if (challenges.isNotEmpty) {
                    Navigator.pop(context);
                    _showChallengeDialog(challenges, username);
                  } else {
                    Navigator.pop(context);
                  }
                },
                buttonOkText:
                    Text('Accept', style: TextStyle(color: CColors.darkWhite)),
                buttonCancelText:
                    Text('Reject', style: TextStyle(color: CColors.darkWhite)),
              ));
    }
  }

  void _acceptChallenge(Challenge challenge, String receiver) {}

  String _getCurrentUserUsername() {
    // TODO implement
    return 'user1';
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
