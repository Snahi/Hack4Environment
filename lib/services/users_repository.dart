import 'package:hack4environment/models/user.dart';

class UsersRepository {
  Future<List<User>> getUsers() async {
    return [
      User('username1', 'email1', 'password1'),
      User('username2', 'email2', 'password1'),
      User('username3', 'email3', 'password1'),
      User('username4', 'email4', 'password1'),
      User('username5', 'email5', 'password1'),
      User('username6', 'email6', 'password1'),
      User('username7', 'email7', 'password1'),
      User('username8', 'email8', 'password1'),
      User('username9', 'email9', 'password1'),
    ];
  }

  Future<bool> challengeUser(String username) async {
    return true;
  }
}
