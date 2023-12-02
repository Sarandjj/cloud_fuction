import 'dart:convert';

Userlistdata userlistdataFromJson(String str) =>
    Userlistdata.fromJson(json.decode(str));

String userlistdataToJson(Userlistdata data) => json.encode(data.toJson());

class Userlistdata {
  List<User>? users = [];

  Userlistdata({
    this.users,
  });

  factory Userlistdata.fromJson(Map<String, dynamic> json) => Userlistdata(
        users: json["users"] == null
            ? []
            : List<User>.from(
                json["users"]!.map((x) => User.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  String? name;
  String? phoneNumber;
  String? email;
  String? uid;

  User({
    this.name,
    this.phoneNumber,
    this.email,
    this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        email: json["email"] ?? "",
        uid: json["uid"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "uid": uid,
      };
}
