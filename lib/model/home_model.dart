import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final int id;
  final String first_name;
  final String middle_name;
  final String last_name;
  final String contact_no;
  final String username;
  bool selected = false;

  User(
      {required this.id,
      required this.first_name,
      required this.middle_name,
      required this.last_name,
      required this.contact_no,
      required this.username});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        first_name: json['first_name'] as String,
        middle_name: json['middle_name'] as String,
        last_name: json['last_name'] as String,
        contact_no: json['contact_no'] as String,
        username: json['username'] as String,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': first_name,
        'middle_name': middle_name,
        'last_name': last_name,
        'contact_no': contact_no,
        'username': username
      };
}
