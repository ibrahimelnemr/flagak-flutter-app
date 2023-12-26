// product class
class User {
  final String userId;
  final String name;
  final String email;
  final String password;

  User({required this.userId, required this.name, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}
