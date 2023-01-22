import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/address.dart';
// import 'package:policesystem/pdf/model/address.dart';

Future<Address> fetchAddress(int id) async {
  final response = await http.get(Uri.parse("$baseUrl/addresses/$id"));
  return Address.fromJson(json.decode(response.body));
}

Future<int?> addAddress(Map<String, dynamic> details) async {
  final response =
      await http.post(Uri.parse('$baseUrl/addresses'), body: details);

  if (response.statusCode == 201) {
    return json.decode(response.body)['id'];
  }
  return null;
}

Future<int?> editAddress(int id, Map<String, dynamic> details) async {
  final response =
      await http.put(Uri.parse('$baseUrl/addresses/$id'), body: details);

  if (response.statusCode == 200) {
    return json.decode(response.body)['id'];
  }
  return null;
}
