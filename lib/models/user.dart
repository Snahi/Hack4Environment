class User {
  final String username;
  final String email;
  final String password;

  User(this.username, this.email, this.password);


  User.fromJson(Map<String, dynamic> json)
      : username = json['usernname'],
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'email': email,
        'password' : password
      };
}