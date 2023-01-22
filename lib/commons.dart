import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const baseScheme = 'http';
const baseHost = '127.0.0.1';
const basePort = 8000;
const baseUrl = '$baseScheme://$baseHost:$basePort/api';

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove('user');

  Navigator.of(context)
      .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
}

showLoaderDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const SizedBox(
        child: Center(child: CircularProgressIndicator()),
      );
    },
  );
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
