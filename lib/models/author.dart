class Author {
  final String firstName;
  final String lastName;
  final String gender;
  final String country;

  Author({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.country,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      firstName: json['Fname'] as String,
      lastName: json['Lname'] as String,
      gender: json['gender'] as String,
      country: json['country'] as String,
    );
  }
}
