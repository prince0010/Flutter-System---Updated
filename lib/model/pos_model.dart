import 'dart:convert';

List<Positions> positionsFromJson(String str) =>
    List<Positions>.from(json.decode(str).map((x) => Positions.fromJson(x)));

String positionsToJson(List<Positions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Positions {
  final int id;
  final String name;
  bool selected = false;

  Positions({required this.id, required this.name});

  factory Positions.fromJson(Map<String, dynamic> json) =>
      Positions(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
