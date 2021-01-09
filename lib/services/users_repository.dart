import 'package:hack4environment/models/challenge.dart';
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

  Future<bool> sendChallenge(Challenge challenge) async {
    // TODO implement
    return true;
  }

  Future<List<Challenge>> getChallenges(String receiver) async {
    return [
      Challenge('user2', 'user1', 7, DateTime(2020, 1, 14)),
      Challenge('user3', 'user1', 30, DateTime(2021, 1, 23))
    ];
  }
}
