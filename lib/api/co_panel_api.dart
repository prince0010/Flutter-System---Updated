import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/co_model.dart';

Future<List<Co>> fetchCo() async {
  Uri url = Uri.parse("http://127.0.0.1:8000/api/co");
  final response = await http.get(url);
  return CoFromJson(response.body);
}

Future<Co?> createOffense(String name) async {
  final response =
      await http.post(Uri.parse('$baseUrl/co'), body: {'name': name});

  if (response.statusCode == 201) {
    return Co.fromJson(json.decode(response.body));
  }
  throw response.body;
}
