import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/zone_model.dart';

Future<List<Zone>> fetchZone() async {
  Uri url = Uri.parse("$baseUrl/zones");
  final response = await http.get(url);
  return zoneFromJson(response.body);
}

Future<Zone?> createZone(String name) async {
  final response =
      await http.post(Uri.parse('$baseUrl/zones'), body: {'name': name});

  if (response.statusCode == 201) {
    return Zone.fromJson(json.decode(response.body));
  }
  throw response.body;
}
