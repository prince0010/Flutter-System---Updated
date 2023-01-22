class Barangay {
  final int id;
  final String name;

  bool selected = false;
  Barangay({required this.id, required this.name});

  factory Barangay.fromJson(Map<String, dynamic> json) =>
      Barangay(id: json['id'], name: json['name']);
}
