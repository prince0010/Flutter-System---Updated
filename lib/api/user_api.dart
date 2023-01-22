import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/user.dart';
import 'package:policesystem/model/user_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  String? savedUser = prefs.getString('user');
  final user = User.fromJson(jsonDecode(savedUser!));
  return user.token!;
}

Future<List<UserItem>> fetchUsers() async {
  final token = await getToken();
  final response = await http.get(Uri.parse('$baseUrl/users'),
      headers: {'Authorization': 'Bearer $token'});

  return (json.decode(response.body) as List<dynamic>)
      .map((e) => UserItem.fromJson(e))
      .toList();
}

Future<User?> createUser(Map<String, dynamic> details) async {
  final token = await getToken();
  final response = await http.post(Uri.parse('$baseUrl/users'),
      headers: {'Authorization': 'Bearer $token'}, body: details);

  if (response.statusCode == 201) {
    return User.fromJson(json.decode(response.body));
  }
  throw response.body;
}

Future<bool?> deleteUser(int id) async {
  final token = await getToken();
  final response = await http.delete(Uri.parse('$baseUrl/users/$id'),
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    return true;
  }
  throw response.body;
}
