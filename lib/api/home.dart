import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/home.dart';

Future<Home> fetchHomepageCounts() async {
  Uri url = Uri.parse("$baseUrl/home");
  final response = await http.get(url);
  return Home.fromJson(json.decode(response.body));
}
