import 'package:flutter/material.dart';
import 'package:hack4environment/models/user.dart';
import 'package:hack4environment/services/users_repository.dart';

// <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Fre

class ChallengeScreen extends StatelessWidget {
  static const String routeName = 'ChallengeScreen';
  final Future<List<User>> _usersFuture = UsersRepository().getUsers();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _usersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
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
            itemCount: users.length,
            itemBuilder: (_, idx) => Card(
                  child: ListTile(
                      title: Text(users[idx].username),
                      trailing: GestureDetector(
                        onTap: () {},
                      )),
                )),
      );
}
