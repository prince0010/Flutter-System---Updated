import 'dart:convert';

List<Zone> zoneFromJson(String str) =>
    List<Zone>.from(json.decode(str).map((x) => Zone.fromJson(x)));

String zoneToJson(List<Zone> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Zone {
  Zone({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  bool selected = false;
  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        id: json["id"] as int,
        name: json["name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
