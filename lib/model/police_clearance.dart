class PoliceClearance {
  final int id;
  final String issuedDate;
  final String createdAt;

  PoliceClearance(
      {required this.id, required this.issuedDate, required this.createdAt});

  factory PoliceClearance.fromJson(Map<String, dynamic> json) =>
      PoliceClearance(
          id: json['id'],
          issuedDate: json['issued_date'],
          createdAt: json['created_at']);
}
