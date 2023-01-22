import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/ranks_model.dart';

Future<List<Ranks>> fetchRanks() async {
  Uri url = Uri.parse("http://127.0.0.1:8000/api/ranks");
  final response = await http.get(url);
  return ranksFromJson(response.body);
}

Future<Ranks?> createRank(String name) async {
  final response =
      await http.post(Uri.parse('$baseUrl/ranks'), body: {'name': name});

  if (response.statusCode == 201) {
    return Ranks.fromJson(json.decode(response.body));
  }
  throw response.body;
}
