import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:policesystem/api/user_api.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final maskFormatter = MaskTextInputFormatter(mask: "+63 (###) ###-####");
  List categoryItemList = [];
  List cateogoryBarangayList = [];

  String firstName = '';
  String lastName = '';
  String middleName = '';
  String contactNo = '';
  String userName = '';
  String password = '';
  String accountType = '1';

  testWindowSize() async {
    await DesktopWindow.setMaxWindowSize(const Size(1600, 900));
    await DesktopWindow.setMinWindowSize(const Size(1280, 720));
  }

  @override
  void initState() {
    super.initState();
    testWindowSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        backgroundColor: const Color.fromARGB(221, 8, 45, 211),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: SingleChildScrollView(
          //Scroll
          child: Form(
            key: _formKey, //Formid pag html
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton(
                        items: [
                          {'id': '1', 'name': 'Admin'},
                          {'id': '2', 'name': 'Clerk'},
                          {'id': '3', 'name': 'Cashier'},
                        ].map((items) {
                          return DropdownMenuItem(
                            value: items['id'],
                            child: Text(
                              items['name'] as String,
                            ),
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            accountType = newvalue as String;
                          });
                        },
                        value: accountType,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment
                      .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text(
                    'Full Name',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            firstName = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Enter First Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Input Your First Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            middleName = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Enter Middle Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Input Your Middle Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            lastName = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Enter Your Last Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Input Your Last Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment
                      .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text(
                    'Contact Number',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      contactNo = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Contact Number",
                  ),
                  inputFormatters: [maskFormatter],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Contact Number";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(
                      child: Text(
                        'Username',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              userName = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Enter Username",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Input Username";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Enter Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input Password";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 50),
                      maximumSize: const Size(80, 50),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        createUser({
                          "usertypeid": accountType,
                          "first_name": firstName,
                          "middle_name": middleName,
                          "last_name": lastName,
                          "contact_no": contactNo,
                          "username": userName,
                          "password": password
                        }).then((user) {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: const Text('Save')),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
