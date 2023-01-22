import 'package:policesystem/model/role.dart';

class User {
  final bool? status;
  final String? token;
  final String? message;
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String contactNo;
  final List<Role> roles;

  User(
      {required this.status,
      this.token,
      this.message,
      required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.contactNo,
      required this.roles});

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json['token'],
        message: json['message'],
        status: json['status'],
        id: json['id'] ?? json['data']['id'],
        firstName: json['first_name'] ?? json['data']['first_name'],
        middleName: json['middle_name'] ?? json['data']['middle_name'],
        lastName: json['last_name'] ?? json['data']['last_name'],
        contactNo: json['contact_no'] ?? json['data']['contact_no'],
        roles: (json['data'] != null &&
                (json['data']['roles'] as List<dynamic>).isNotEmpty)
            ? (json['data']['roles'] as List<dynamic>)
                .map((e) => Role.fromJson(e))
                .toList()
            : [],
      );

  bool get isClerk => roles.where((role) => role.name == 'clerk').isNotEmpty;
  bool get isAdmin => roles.where((role) => role.name == 'admin').isNotEmpty;
  bool get isCashier =>
      roles.where((role) => role.name == 'cashier').isNotEmpty;

  Map<String, dynamic> toJson() => {
        'status': status,
        'token': token,
        'message': message,
        'data': {
          'id': id,
          'first_name': firstName,
          'middle_name': middleName,
          'last_name': lastName,
          'contact_no': contactNo,
          'roles': roles.map((e) => e.toJson()).toList()
        }
      };
}
