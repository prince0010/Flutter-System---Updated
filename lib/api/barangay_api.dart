import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/barangay.dart';

Future<List<Barangay>> fetchBarangay() async {
  Uri url = Uri.parse("$baseUrl/barangays");
  final response = await http.get(url);
  return (json.decode(response.body) as List<dynamic>)
      .map((e) => Barangay.fromJson(e))
      .toList();
}

Future<Barangay?> createBarangay(String name) async {
  final response =
      await http.post(Uri.parse('$baseUrl/barangays'), body: {'name': name});

  if (response.statusCode == 201) {
    return Barangay.fromJson(json.decode(response.body));
  }
  throw response.body;
}
