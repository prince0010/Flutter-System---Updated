import 'dart:convert';

List<Ranks> ranksFromJson(String str) =>
    List<Ranks>.from(json.decode(str).map((x) => Ranks.fromJson(x)));

String ranksToJson(List<Ranks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ranks {
  final int id;
  final String name;
  bool selected = false;

  Ranks({required this.id, required this.name});

  factory Ranks.fromJson(Map<String, dynamic> json) => Ranks(
        id: json['id'] as int,
        name: json['name'],
      );
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
