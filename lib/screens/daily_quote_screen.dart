import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hack4environment/resources/c_colors.dart';
import 'package:hack4environment/resources/images.dart';
import 'package:hack4environment/resources/strings.dart';

class DailyQuoteScreen extends StatefulWidget {
  static const String routeName = 'DailyQuote';

  @override
  _DailyQuoteScreenState createState() => _DailyQuoteScreenState();
}

class _DailyQuoteScreenState extends State<DailyQuoteScreen> {
  @override
  Widget build(BuildContext context) {
    var random = Random().nextInt(20) + 1;

    var imageName = Strings.imageName + random.toString() + '.jpg';

    print(imageName);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.homeScreenAppBar),
        leading: Image.asset(Images.appLogo),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text(
              Strings.quoteOfTheDay,
              style: TextStyle(
                  color: CColors.lightBlack,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            Container(
              child: Image.asset(imageName),
              width: 350,
              height: 500,
            )
          ],
        ),
      ),
    );
  }
}
