class Address {
  final int id;
  final int zoneId;
  final int barangayId;

  Address({required this.id, required this.zoneId, required this.barangayId});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      id: json['id'], barangayId: json['barangay_id'], zoneId: json['zone_id']);
}
