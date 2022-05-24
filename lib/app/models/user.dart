class User {
  final int id;
  final String? firstName;

  User({
    required this.id,
    required this.firstName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
    );
  }
}
