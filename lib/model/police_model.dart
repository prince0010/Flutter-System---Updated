import 'dart:convert';

List<Police> employeesFromJson(String str) =>
    List<Police>.from(json.decode(str).map((x) => Police.fromJson(x)));

String employeesToJson(List<Police> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Police {
  Police(
      {required this.id,
      required this.first_name,
      required this.middle_name,
      required this.last_name,
      required this.contact_no,
      required this.rank_id,
      required this.position_id,
      required this.rank,
      required this.position});

  final int id;
  final String first_name;
  final String middle_name;
  final String last_name;
  final String contact_no;
  final int rank_id;
  final int position_id;
  final String? rank;
  final String? position;

  bool selected = false;
  factory Police.fromJson(Map<String, dynamic> json) => Police(
        id: json["id"] as int,
        first_name: json["first_name"] as String,
        middle_name: json["middle_name"] as String,
        last_name: json["last_name"] as String,
        contact_no: json["contact_no"] as String,
        rank_id: json["rank_id"] as int,
        position_id: json["position_id"] as int,
        position: json['position'],
        rank: json['rank'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": first_name,
        "middle_name": middle_name,
        "last_name": last_name,
        "contact_no": contact_no,
        "rank_id": rank_id,
        "position_id": position_id,
        "position": position,
        "rank": rank
      };
}
