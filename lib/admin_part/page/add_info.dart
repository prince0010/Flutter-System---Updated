import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:policesystem/admin_part/DatabaseHandler/databaseconnection.dart';
import 'package:policesystem/admin_part/Field/genloginandaddHeader.dart';
import 'package:policesystem/admin_part/Model/userModel.dart';
import 'package:policesystem/admin_part/services/userService.dart';

import '../Field/genTextFormField.dart';
import 'login_page.dart';

class AddInfo extends StatefulWidget {
  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  final maskFormatter = MaskTextInputFormatter(mask: "+63 (###) ###-####");
  var _fullnameController = TextEditingController();
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _addressController = TextEditingController();
  var _mobilenumController = TextEditingController();
  bool _validatefullname = false;
  bool _validateusername = false;
  bool _validatepassword = false;
  bool _validateaddress = false;
  bool _validatemobilenum = false;
  // var _userService = UserService();
  //create initState Method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Info"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Info',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _fullnameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Full Name",
                  labelText: "Fullname",
                  errorText:
                      _validatefullname ? 'Fullname Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Username",
                  labelText: "Username",
                  errorText:
                      _validateusername ? 'Username Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Password",
                  labelText: "Password",
                  errorText:
                      _validatepassword ? 'Password Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Address",
                  labelText: "Address",
                  errorText:
                      _validateaddress ? 'Adrress Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _mobilenumController,
                inputFormatters: [maskFormatter],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Mobile Number",
                  labelText: "Mobile Number",
                  errorText: _validatemobilenum
                      ? 'Mobile Number Can\'t Be Empty'
                      : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromARGB(255, 4, 62, 109),
                      textStyle: const TextStyle(fontSize: 15.0),
                    ),
                    onPressed: () async {
                      setState(() {
                        _fullnameController.text.isEmpty
                            ? _validatefullname = true
                            : _validatefullname = false;
                        _usernameController.text.isEmpty
                            ? _validateusername = true
                            : _validateusername = false;
                        _passwordController.text.isEmpty
                            ? _validatepassword = true
                            : _validatepassword = false;
                        _addressController.text.isEmpty
                            ? _validateaddress = true
                            : _validateaddress = false;
                        _mobilenumController.text.isEmpty
                            ? _validatemobilenum = true
                            : _validatemobilenum = false;
                      });
                      if (_validatefullname == false &&
                          _validateusername == false &&
                          _validatepassword == false &&
                          _validateaddress == false &&
                          _validatemobilenum == false) {
                        // print("Good Data Can Save");
                        var _user = UserModel();
                        _user.full_name = _fullnameController.text;
                        _user.username = _usernameController.text;
                        _user.password = _passwordController.text;
                        _user.address = _addressController.text;
                        _user.phone_num = _mobilenumController.text;
                        // var result = await _userService.SaveUser(_user);
                        // print(result);
                        // Navigator.pop(context, result);
                      }
                    },
                    child: const Text('Add Info'),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromARGB(255, 4, 62, 109),
                      textStyle: const TextStyle(fontSize: 15.0),
                    ),
                    onPressed: () {
                      _fullnameController.text = '';
                      _usernameController.text = '';
                      _passwordController.text = '';
                      _addressController.text = '';
                      _mobilenumController.text = '';
                    },
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
