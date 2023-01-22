import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:policesystem/commons.dart';
import 'package:policesystem/panel/signature_panel.dart';
import 'package:http/http.dart' as http;

class FormPanel extends StatefulWidget {
  const FormPanel({Key? key}) : super(key: key);

  @override
  _FormPanelState createState() => _FormPanelState();
}

class _FormPanelState extends State<FormPanel> {
  final _formKey = GlobalKey<FormState>();
  final maskFormatter = MaskTextInputFormatter(mask: "+63 (###) ###-####");
  final maskFormatter2 = MaskTextInputFormatter(mask: "##-##-####");
  List categoryItemList = [];
  List cateogoryBarangayList = [];
// ===================================== Start API CALL for zone ==========================================================
  Future getAllCategory() async {
    var baseURL = '$baseUrl/zones';

    http.Response response = await http.get(Uri.parse(baseURL));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemList = jsonData;
      });
    }
  }
// =====================================End API CALL for zone ==========================================================

// ===================================== Start API CALL for Barangay ==========================================================

  Future getAllBarangay() async {
    var baseurl = '$baseUrl/barangays';

    http.Response resp1 = await http.get(Uri.parse(baseurl));
    if (resp1.statusCode == 200) {
      var jsonData = json.decode(resp1.body);
      setState(() {
        cateogoryBarangayList = jsonData;
      });
    }
  }

// =====================================End API CALL for barangay ==========================================================

  @override
  void initState() {
    super.initState();
    getAllCategory();
    getAllBarangay();
  }

  // List of items in our dropdown menu
  _FormPanelState() {
    // _barangayListSelected = _zoneListSelected;
    selectcs = civilStatus[0];
    selectsex = sex[0];
  }
  String selectsex = "";
  List<String> sex = ['Male', 'Female'];

  String selectcs = " ";
  List<String> civilStatus = [
    'Single',
    'Married',
    'Widow',
    'Widower',
    'Legally Separated'
  ];

  var dropdownvalue;
  var dropdownvalues;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(221, 8, 45, 211),
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
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter First Name",
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Input Your Full Name";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter Middle Name",
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Input Your Full Name";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter Your Last Name",
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Input Your Full Name";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),

                const Align(
                  alignment: Alignment
                      .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text(
                    'Address',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButton(
                        // value: _myState,
                        // onChanged: (String val) {
                        //   // setState(() {
                        //   //   _myState = val;
                        //   //   _getZoneList;
                        //   //   print(_myState);
                        //   // });
                        // },
                        items: categoryItemList.map((itemoned) {
                          return DropdownMenuItem(
                              value: itemoned['id'],
                              child: Text(itemoned['name'].toString()));
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            dropdownvalue = newvalue;
                            print(newvalue);
                          });
                        },
                        value: dropdownvalue,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: DropdownButton(
                        // value: _myState,
                        // onChanged: (String val) {
                        //   // setState(() {
                        //   //   _myState = val;
                        //   //   _getZoneList;
                        //   //   print(_myState);
                        //   // });
                        // },
                        items: cateogoryBarangayList.map((items) {
                          return DropdownMenuItem(
                              value: items['id'],
                              child: Text(items['name'].toString()));
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            dropdownvalues = newvalue;
                            print(dropdownvalues);
                          });
                        },
                        value: dropdownvalues,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                // ,
                Row(
                  children: const <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment
                          .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                      child: Text(
                        'Place of Birth',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    )),
                    SizedBox(width: 40),
                    Expanded(
                        child: Align(
                      alignment: Alignment
                          .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                      child: Text(
                        'Date of Birth',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    )),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Place of Birth",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Place of Birth";
                        } else {
                          return null;
                        }
                      },
                    )),
                    const SizedBox(width: 40),
                    Expanded(
                        child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Date of Birth (Month-Day-Year)",
                      ),
                      inputFormatters: [maskFormatter2],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Birthday";
                        } else {
                          return null;
                        }
                      },
                    ))
                  ],
                ),

                const SizedBox(height: 16),
                Row(
                  children: const <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment
                          .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                      child: Text(
                        'Sex',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    )),
                    SizedBox(width: 40),
                    Expanded(
                        child: Align(
                      alignment: Alignment
                          .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                      child: Text(
                        'Civil Status',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: DropdownButton(
                      value: selectsex,
                      onChanged: (newvalue) {
                        setState(() {
                          selectsex = newvalue.toString();
                          print(newvalue);
                        });
                      },
                      items: sex.map((itemgen) {
                        return DropdownMenuItem(
                            value: itemgen, child: Text(itemgen));
                      }).toList(),
                    )),
                    const SizedBox(width: 40),
                    Expanded(
                        child: DropdownButton(
                      value: selectcs,
                      onChanged: (value) {
                        setState(() {
                          selectcs = value.toString();
                        });
                      },
                      items: civilStatus.map((itemone) {
                        return DropdownMenuItem(
                            value: itemone, child: Text(itemone));
                      }).toList(),
                    )),
                  ],
                ),

                const SizedBox(height: 16),
                Row(
                  children: const <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment
                            .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          'Nationality',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                        child: Align(
                      alignment: Alignment
                          .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                      child: Text(
                        'Height',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Nationality",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Nationality";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    //Age Input box
                    const SizedBox(width: 40),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Age",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Age";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    //Height Input Box
                    const SizedBox(width: 40),
                    Expanded(
                        child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Age",
                      ),
                      inputFormatters: [maskFormatter2],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Height";
                        } else {
                          return null;
                        }
                      },
                    ))
                  ],
                ),

                //Contact Number
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 50),
                    maximumSize: const Size(80, 50),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SignaturePanel()));
                  },
                  child: const Text('Next'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
