// import 'dart:convert';

// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/police_model.dart';
// import 'package:policesystem/admin_model/police_model.dart';

// Future<List<Police>> fetchPolice() async {
//   var url = 'http://127.0.0.1:8000/api/police';
//   var result = await http.get(Uri.parse(url));
//   if (result.statusCode == 200) {
//     var parsed = json.decode(result.body);
//     return parsed.map<Police>((job) => Police.fromJson(job)).toList();
//   } else {
//     throw Exception('Failed to Connect');
//   }
// }

Future<List<Police>> fetchPolice() async {
  Uri url = Uri.parse("$baseUrl/police");
  final response = await http.get(url);
  return employeesFromJson(response.body);
}

Future<Police?> createPolice(Map<String, dynamic> data) async {
  try {
    final response = await http.post(Uri.parse('$baseUrl/police'), body: data);

    if (response.statusCode == 201) {
      return Police.fromJson(json.decode(response.body));
    }
    throw response.body;
  } catch (e) {
    print(e);
  }
  return null;
}
