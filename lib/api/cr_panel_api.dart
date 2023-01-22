import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/cr_model.dart';

Future<List<Cr>> fetchCr({Map<String, dynamic>? params}) async {
  Uri url = Uri.parse("$baseUrl/cr");
  if (params != null) {
    url = Uri(
        scheme: baseScheme,
        host: baseHost,
        port: basePort,
        path: '/api/cr',
        queryParameters: params);
  }
  final response = await http.get(url);
  return CrFromJson(response.body);
}

Future<Cr?> createCriminalRecord(Map<String, dynamic> details) async {
  final response = await http.post(Uri.parse('$baseUrl/cr'), body: details);

  if (response.statusCode == 201) {
    return Cr.fromJson(json.decode(response.body));
  }
  throw response.body;
}
