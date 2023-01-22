import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/police_clearance_details.dart';

Future<int?> addPcc(Map<String, dynamic> details) async {
  final response = await http.post(Uri.parse('$baseUrl/pcc'), body: details);

  if (response.statusCode == 201) {
    return json.decode(response.body)['id'] as int;
  }
  return null;
}

Future<int?> addPccd(Map<String, dynamic> details) async {
  final response = await http.post(Uri.parse('$baseUrl/pccd'), body: details);

  if (response.statusCode == 201) {
    return json.decode(response.body)['id'] as int;
  }
  return null;
}

Future<void> deletePcc(int id) async {
  final response = await http.delete(Uri.parse('$baseUrl/pccd/$id'));
  print(response.statusCode);
}

Future<int?> editPccd(int id, Map<String, dynamic> details) async {
  final response =
      await http.put(Uri.parse('$baseUrl/pccd/$id'), body: details);

  if (response.statusCode == 200) {
    return json.decode(response.body)['id'] as int;
  }
  return null;
}

Future<List<PoliceClearanceDetails>?> getPccd() async {
  final response = await http.get(Uri.parse('$baseUrl/pccd'));

  if (response.statusCode == 200) {
    try {
      return (json.decode(response.body) as List<dynamic>)
          .map((e) => PoliceClearanceDetails.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }
  }
  return null;
}
