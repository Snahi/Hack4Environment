import 'package:flutter/material.dart';
import 'package:hack4environment/models/challenge.dart';
import 'package:hack4environment/models/user.dart';
import 'package:hack4environment/resources/images.dart';
import 'package:hack4environment/resources/strings.dart';
import 'package:hack4environment/screens/home/home_screen.dart';
import 'package:hack4environment/services/users_repository.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

// <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Fre
// <a href='https://www.freepik.com/vectors/abstract'>Abstract vector created by pch.vector - www.freepik.com</a>

class ChallengeScreen extends StatefulWidget {
  static const String routeName = 'ChallengeScreen';

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen>
    with TickerProviderStateMixin {
  final UsersRepository _usersRepo = UsersRepository();
  Future<List<User>> usersFuture;
  String searchedUser;
  List<User> _users;

  @override
  void initState() {
    super.initState();
    usersFuture = _usersRepo.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: usersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          _users = snapshot.data as List<User>;
          return _buildContent(snapshot.data as List<User>);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildContent(List<User> users) => Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: searchedUser == null || searchedUser.isEmpty
              ? users.length
              : (_users
                      .where((element) => element.username == searchedUser)
                      .isNotEmpty
                  ? 2
                  : 1),
          itemBuilder: (_, idx) =>
              idx == 0 ? SearchCard(_searchUser) : _buildTile(users[idx]),
        ),
      );

  Widget _buildTile(User user) {
    if (searchedUser != null && searchedUser.isNotEmpty) {
      return _buildTileByName(searchedUser);
    } else {
      return _buildTileByName(user.username);
    }
  }

  Widget _buildTileByName(String name) => Card(
        child: ListTile(
            title: Text(name),
            trailing: GestureDetector(
              onTap: () {
                _sendChallenge(name);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(Images.challenge),
              ),
            )),
      );

  void _searchUser(String username) {
    setState(() {
      searchedUser = username;
    });
  }

  void _sendChallenge(String username) {
    // TODO sender
    UsersRepository().sendChallenge(Challenge('user1', 'user2'));
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset(Images.challengeSent),
              title: Text(
                Strings.challengeSent,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(Strings.waitForResponse),
              entryAnimation: EntryAnimation.DEFAULT,
              onOkButtonPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(HomeScreen.routeName));
              },
              onlyOkButton: true,
            ));
  }
}

class SearchCard extends StatefulWidget {
  final Function(String) callbackUsername;

  SearchCard(this.callbackUsername);

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  final usernameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Container(
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                Strings.challengeUser,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: usernameInputController,
                      ),
                    ),
                    SizedBox(width: 16),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        widget.callbackUsername(usernameInputController.text);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameInputController.dispose();
    super.dispose();
  }
}
