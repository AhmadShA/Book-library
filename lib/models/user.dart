class User {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String address;
  final String email;

  Uer({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['userName'] as String,
      password: json['Password'] as String,
      firstName: json['Fname'] as String,
      lastName: json['Lname'] as String,
      address: json['Address'] as String,
      email: json['Email'] as String,
    );
  }
}
