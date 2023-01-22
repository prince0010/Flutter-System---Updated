import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:policesystem/api/cr_panel_api.dart';
import 'package:policesystem/api/user_api.dart';

class CriminalForm extends StatefulWidget {
  const CriminalForm({Key? key}) : super(key: key);
  @override
  _CriminalFormState createState() => _CriminalFormState();
}

class _CriminalFormState extends State<CriminalForm> {
  final _formKey = GlobalKey<FormState>();
  final maskFormatter = MaskTextInputFormatter(mask: "+63 (###) ###-####");
  final maskFormatter2 = MaskTextInputFormatter(mask: "##-##-####");

  String firstName = '';
  String lastName = '';
  String middleName = '';
  String contactNo = '';
  String userName = '';
  String password = '';
  String bdate = '1';

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
        title: const Text('Add Criminal Record'),
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
                    'Birth Date',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Date of Birth (Month-Day-Year)",
                  ),
                  onChanged: (value) {
                    setState(() {
                      bdate = value;
                    });
                  },
                  inputFormatters: [maskFormatter2],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Birthday";
                    } else {
                      return null;
                    }
                  },
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

                        createCriminalRecord({
                          "first_name": firstName,
                          "middle_name": middleName,
                          "last_name": lastName,
                          "date_of_birth": bdate,
                        }).then((user) {
                          print(user);
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
