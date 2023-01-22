import 'package:flutter/material.dart';

class SignaturePanel extends StatefulWidget {
  const SignaturePanel({Key? key}) : super(key: key);

  @override
  State<SignaturePanel> createState() => _SignaturePanel();
}

class _SignaturePanel extends State<SignaturePanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Add User Profile'),
    ));
  }
}
