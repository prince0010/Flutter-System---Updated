import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:policesystem/commons.dart';

Future<int?> addPayment(Map<String, dynamic> details) async {
  final response =
      await http.post(Uri.parse('$baseUrl/payments'), body: details);

  if (response.statusCode == 201) {
    return json.decode(response.body)['id'] as int;
  }
  return null;
}
