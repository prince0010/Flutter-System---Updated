import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:policesystem/api/police_api.dart';
import 'package:policesystem/api/pos_panel_api.dart';
import 'package:policesystem/api/rank_panel_api.dart';
import 'package:policesystem/api/user_api.dart';
import 'package:policesystem/model/pos_model.dart';
import 'package:policesystem/model/ranks_model.dart';

class PoliceForm extends StatefulWidget {
  const PoliceForm({Key? key}) : super(key: key);
  @override
  _PoliceFormState createState() => _PoliceFormState();
}

class _PoliceFormState extends State<PoliceForm> {
  final _formKey = GlobalKey<FormState>();
  final maskFormatter = MaskTextInputFormatter(mask: "+63 (###) ###-####");
  List<Ranks> ranks = [];
  List<Positions> positions = [];

  String firstName = '';
  String lastName = '';
  String middleName = '';
  String contactNo = '';
  String userName = '';
  String password = '';
  int? rank;
  int? position;

  testWindowSize() async {
    await DesktopWindow.setMaxWindowSize(const Size(1600, 900));
    await DesktopWindow.setMinWindowSize(const Size(1280, 720));
  }

  @override
  void initState() {
    super.initState();
    testWindowSize();
    getDropdown();
  }

  void getDropdown() {
    fetchRanks().then((value) {
      setState(() {
        ranks = value;
        rank = value.first.id;
      });
    });

    fetchPositions().then((value) {
      setState(() {
        positions = value;
        position = value.first.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Police'),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Rank',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Text(
                      'Position',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (ranks.isNotEmpty)
                      DropdownButton(
                        items: ranks.map((items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Text(
                              items.name,
                            ),
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            rank = newvalue as int;
                          });
                        },
                        value: rank,
                      ),
                    if (positions.isNotEmpty)
                      DropdownButton(
                        items: positions.map((items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Text(
                              items.name,
                            ),
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            position = newvalue as int;
                          });
                        },
                        value: position,
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

                        createPolice({
                          "first_name": firstName,
                          "middle_name": middleName,
                          "last_name": lastName,
                          "contact_no": contactNo,
                          "rank_id": rank.toString(),
                          "position_id": position.toString(),
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
