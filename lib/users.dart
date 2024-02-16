class User {
  final String uid;
  final String name;
  final String email;

  User({
    required this.uid,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    "uid" : uid,
    "name" : name,
    "email" : email
  };
}