import 'dart:convert';

// List<Users> usersFromJson(String str) =>
//     List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

List<Users> usersFromPagedJson(String str) {
  Map<String, dynamic> data = json.decode(str);

  List<Users> listUsers = (data['data'] as List<dynamic>)
      .map((user) => Users.fromPagedJson(user))
      .toList() as List<Users>;
  return listUsers;
}

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  final int id;
  final String first_name;
  final String middle_name;
  final String last_name;
  final String contact_no;
  final String username;
  // final int roles;
  bool selected = false;

  Users({
    required this.id,
    required this.first_name,
    required this.middle_name,
    required this.last_name,
    required this.contact_no,
    required this.username,
    // required this.roles
  });

  // factory Users.fromJson(Map<String, dynamic> json) => Users(
  //       id: json['id'] as int,
  //       first_name: json['first_name'] as String,
  //       middle_name: json['middle_name'] as String,
  //       last_name: json['last_name'] as String,
  //       contact_no: json['contact_no'] as String,
  //       username: json['username'] as String,
  //       // roles: json['roles'] as int,
  //     );
  factory Users.fromPagedJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as int,
      first_name: json['first_name'] as String,
      middle_name: json['middle_name'] as String,
      last_name: json['last_name'] as String,
      contact_no: json['contact_no'] as String,
      username: json['username'] as String,
      // roles: json['roles'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': first_name,
        'middle_name': middle_name,
        'last_name': last_name,
        'contact_no': contact_no,
        'username': username,
        // 'roles': roles
      };
}
