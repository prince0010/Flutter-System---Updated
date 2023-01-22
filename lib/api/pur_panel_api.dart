import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/pur_model.dart';

Future<List<Purpose>> fetchPur() async {
  Uri url = Uri.parse("$baseUrl/purposes");
  final response = await http.get(url);
  return purFromJson(response.body);
}

Future<Purpose?> createPurpose(String name) async {
  final response =
      await http.post(Uri.parse('$baseUrl/purposes'), body: {'name': name});

  if (response.statusCode == 201) {
    return Purpose.fromJson(json.decode(response.body));
  }
  throw response.body;
}
