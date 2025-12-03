
class User {
  final int? userID;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String role;

  User({
    this.userID,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userID: map['userID'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
      role: map['role'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
    };
  }
}