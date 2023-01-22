import 'dart:convert';

List<Co> CoFromJson(String str) =>
    List<Co>.from(json.decode(str).map((x) => Co.fromJson(x)));

String CoToJson(List<Co> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Co {
  final int id;
  final String name;
  //This is for the selection checkbox list in datatable
  bool selected = false;

  Co({required this.id, required this.name});

  factory Co.fromJson(Map<String, dynamic> json) =>
      Co(id: json['id'] as int, name: json['name'] as String);
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
