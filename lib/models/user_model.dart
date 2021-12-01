class User {
  String uid;
  String firstName;
  String lastName;
  String online;
  String username;
  String phone;
  String userImgUrl;
  late bool appUser;

  User(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.online,
      required this.phone,
      required this.username,
      required this.userImgUrl,
      this.appUser = false});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      lastName: json['lastname'] != null ? json['lastname'] : "",
      firstName: json['firstname'] != null ? json['firstname'] : "",
      online: json['online'] != null ? json['online'] : "N",
      username: json['username'] != null ? json['username'] : "",
      phone: json['phone'] != null ? json['phone'] : "",
      userImgUrl: json['usrimgurl'] != null ? json['usrimgurl'] : "",
      appUser: json['appuser'] != null ? json['appuser'] : false,
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstname": firstName,
        "lastname": lastName,
        "online": online,
        "username": username,
        "phone": phone,
        "usrimgurl": userImgUrl,
        "appuser": appUser
      };
}