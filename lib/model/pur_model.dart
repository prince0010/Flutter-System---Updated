import 'dart:convert';

List<Purpose> purFromJson(String str) =>
    List<Purpose>.from(json.decode(str).map((x) => Purpose.fromJson(x)));

String purToJson(List<Purpose> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Purpose {
  final int id;
  final String name;
  bool selected = false;

  Purpose({required this.id, required this.name});

  factory Purpose.fromJson(Map<String, dynamic> json) => Purpose(
        id: json['id'] as int,
        name: json['name'],
      );
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
