class User {
  final String username;
  final String email;
  final String password;

  User(this.username, this.email, this.password);

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJsonRegister() =>
      {'username': username, 'email': email, 'password': password};

  Map<String, dynamic> toJsonLogin() =>
      {'username': username, 'password': password};
}
