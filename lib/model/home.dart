class Home {
  final int users;
  final int police;
  final int applicants;

  Home({required this.users, required this.police, required this.applicants});

  factory Home.fromJson(Map<String, dynamic> json) => Home(
      users: json['users'],
      police: json['police'],
      applicants: json['applicants']);
}
