import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/applicant.dart';

Future<int?> addApplicant(Map<String, dynamic> details) async {
  final response =
      await http.post(Uri.parse('$baseUrl/applicants'), body: details);

  if (response.statusCode == 201) {
    return json.decode(response.body)['id'] as int;
  }
  return null;
}

Future<int?> addApplicantDetails(Map<String, dynamic> details) async {
  final response =
      await http.post(Uri.parse('$baseUrl/applicant-details'), body: details);

  if (response.statusCode == 201) {
    return json.decode(response.body)['id'] as int;
  }
  return null;
}

Future<Map<String, dynamic>?> getApplicantDetails(int id) async {
  final response = await http.get(Uri.parse('$baseUrl/applicant-details/$id'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
  return null;
}

Future<int?> editApplicant(int id, Map<String, dynamic> details) async {
  final response =
      await http.put(Uri.parse('$baseUrl/applicants/$id'), body: details);

  if (response.statusCode == 200) {
    return json.decode(response.body)['id'] as int;
  }
  return null;
}

Future<int?> addCtc(Map<String, dynamic> details) async {
  final response = await http.post(Uri.parse('$baseUrl/ctc'), body: details);

  if (response.statusCode == 201) {
    return json.decode(response.body)['id'] as int;
  }
  return null;
}

Future<int?> editCtc(int id, Map<String, dynamic> details) async {
  final response = await http.put(Uri.parse('$baseUrl/ctc/$id'), body: details);

  if (response.statusCode == 200) {
    return json.decode(response.body)['id'] as int;
  }
  return null;
}
