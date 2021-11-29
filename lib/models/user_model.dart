class User {
  String uid;
  String firstName;
  String lastName;
  String online;

  User(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.online});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      lastName: json['lastname'],
      firstName: json['firstname'],
      online: json['online'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstname": firstName,
        "lastname": lastName,
        "online": online
      };
}
