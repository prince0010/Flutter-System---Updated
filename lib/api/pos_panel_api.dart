import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/pos_model.dart';

Future<List<Positions>> fetchPositions() async {
  Uri url = Uri.parse("http://127.0.0.1:8000/api/positions");
  final response = await http.get(url);
  return positionsFromJson(response.body);
}

Future<Positions?> createPosition(String name) async {
  final response =
      await http.post(Uri.parse('$baseUrl/positions'), body: {'name': name});

  if (response.statusCode == 201) {
    return Positions.fromJson(json.decode(response.body));
  }
  throw response.body;
}
