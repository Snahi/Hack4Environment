import 'package:hack4environment/models/user.dart';

class Ranking {
  final int id;
  final int userId;
  final String user;
  final double points;

  Ranking(this.id, this.userId, this.user, this.points);

  Ranking.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        user = json['userName'],
        points = json['points'];
}
