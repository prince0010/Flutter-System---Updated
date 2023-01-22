import 'dart:convert';

List<Cr> CrFromJson(String str) =>
    List<Cr>.from(json.decode(str).map((x) => Cr.fromJson(x)));

String CrToJson(List<Cr> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cr {
  final int id;
  final String first_name;
  final String middle_name;
  final String last_name;
  bool selected = false;

  Cr({
    required this.id,
    required this.first_name,
    required this.middle_name,
    required this.last_name,
  });

  factory Cr.fromJson(Map<String, dynamic> json) => Cr(
        id: json['id'] as int,
        first_name: json['first_name'] as String,
        middle_name: json['middle_name'] as String,
        last_name: json['last_name'] as String,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': first_name,
        'middle_name': middle_name,
        'last_name': last_name,
      };
}
