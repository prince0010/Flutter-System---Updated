class UserItem {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String contactNo;
  final String username;

  UserItem({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.contactNo,
    required this.username,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
        id: json['id'],
        firstName: json['first_name'],
        middleName: json['middle_name'],
        lastName: json['last_name'],
        contactNo: json['contact_no'],
        username: json['username'],
      );
}
