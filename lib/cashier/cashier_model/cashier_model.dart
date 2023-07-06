import 'dart:convert';

List<Payment> PaymentFromJson(String str) =>
    List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String PaymentToJson(List<Payment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
  final int id;
  final String or_number;
  final String payment;

  //This is for the selection checkbox list in Data Table
  bool selected = false;

  Payment({required this.id, required this.or_number, required this.payment});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
      id: json['id'] as int,
      or_number: json['or_number'] as String,
      payment: json['payment']);
  Map<String, dynamic> toJson() => {'id': id, 'or_number': or_number};
}
