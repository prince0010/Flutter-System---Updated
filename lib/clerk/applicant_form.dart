// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:policesystem/api/addresses_api.dart';
import 'package:policesystem/api/applicant_api.dart';
import 'package:policesystem/api/barangay_api.dart';
import 'package:policesystem/api/pcc_api.dart';
import 'package:policesystem/api/pur_panel_api.dart';
import 'package:policesystem/api/zone_api.dart';
import 'package:policesystem/model/barangay.dart';
import 'package:policesystem/model/police_clearance_details.dart';
import 'package:policesystem/model/pur_model.dart';
import 'package:policesystem/model/zone_model.dart';

import 'package:policesystem/commons.dart';
import 'package:policesystem/panel/signature_panel.dart';
import 'package:policesystem/pdf_generator/generate_certificate.dart';

class ApplicantForm extends StatefulWidget {
  const ApplicantForm({super.key, this.applicant});

  final PoliceClearanceDetails? applicant;

  @override
  State<ApplicantForm> createState() => _ApplicantFormState();
}

class _ApplicantFormState extends State<ApplicantForm> {
  final _formKey = GlobalKey<FormState>();
  final maskFormatter = MaskTextInputFormatter(mask: "+63 (###) ###-####");
  final maskFormatter2 = MaskTextInputFormatter(mask: "##-##-####");
  final heightFormatter = MaskTextInputFormatter(mask: "#'##");
  List<Zone> zones = [];
  List<Barangay> cateogoryBarangayList = [];
  List<Purpose> purposes = [];

  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController middleNameCtrl = TextEditingController();
  TextEditingController placeOfBirthCtrl = TextEditingController();
  TextEditingController dateOfBirthCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();
  TextEditingController contactCtrl = TextEditingController();
  TextEditingController ctcNumberCtrl = TextEditingController();
  TextEditingController nationalityCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController issuedAtCtrl = TextEditingController();
  TextEditingController issuedOnCtrl = TextEditingController();

  // String? firstName;
  // String? lastName;
  // String? middleName;
  // String? placeOfBirth;
  // String? dateOfBirth;
  // String? contact;

  // String? height;
  // String? nationality;
  // String? ctcNumber;
  // String? issuedOn;
  // String? issuedAt;
  String? status;
  int? selectedZone;
  int? selectedBarangay;
  int? selectedPurpose;

  String selectsex = "Male";
  List<String> sex = ['Male', 'Female'];
  String selectcs = "Single";
  List<String> civilStatus = [
    'Single',
    'Married',
    'Widow',
    'Widower',
    'Legally Separated'
  ];

  @override
  void initState() {
    fetchDropDowns();
    super.initState();
    fetchApplicant();
  }

  void fetchApplicant() async {
    if (widget.applicant != null) {
      final address = await fetchAddress(widget.applicant!.applicant.addressId);

      setState(() {
        selectedPurpose = widget.applicant!.purposeId;
        firstNameCtrl.text = widget.applicant!.applicant.firstName;
        middleNameCtrl.text = widget.applicant!.applicant.middleName;
        lastNameCtrl.text = widget.applicant!.applicant.lastName;
        placeOfBirthCtrl.text = widget.applicant!.applicant.placeOfBirth;
        heightCtrl.text = widget.applicant!.applicant.height;
        ctcNumberCtrl.text = widget.applicant!.ctc.ctcNumber;
        nationalityCtrl.text = widget.applicant!.applicant.nationality;
        issuedAtCtrl.text = widget.applicant!.ctc.placeIssue;
        dateOfBirthCtrl.text = DateFormat('MM-dd-yyyy')
            .format(DateTime.parse(widget.applicant!.applicant.dateOfBirth));
        issuedOnCtrl.text = DateFormat('MM-dd-yyyy')
            .format(DateTime.parse(widget.applicant!.ctc.dateIssue));
        selectsex = widget.applicant!.applicant.sex.toTitleCase();
        contactCtrl.text = widget.applicant!.applicant.contactNo;
        // ageCtrl.text = widget.applicant!.applicant.age;
        selectedZone = address.zoneId;
        selectedBarangay = address.barangayId;
      });
    }
  }

  void fetchDropDowns() async {
    final tempZones = await fetchZone();
    final barangays = await fetchBarangay();
    final tempPurposes = await fetchPur();

    setState(() {
      zones = tempZones;
      cateogoryBarangayList = barangays;
      purposes = tempPurposes;
    });
  }

  void saveNewForm(BuildContext context) async {
    try {
      final addressId = await addAddress({
        'zone_name': selectedZone.toString(),
        'barangay_name': selectedBarangay.toString()
      });

      var rawDate = dateOfBirthCtrl.text.split('-');
      final applicantId = await addApplicant({
        "first_name": firstNameCtrl.text,
        "middle_name": middleNameCtrl.text,
        "last_name": lastNameCtrl.text,
        "contact_no": contactCtrl.text,
        "date_of_birth": '${rawDate[2]}-${rawDate[0]}-${rawDate[1]}',
        "place_of_birth": placeOfBirthCtrl.text,
        "civil_status": selectcs,
        "height": heightCtrl.text,
        "sex": selectsex,
        "nationality": nationalityCtrl.text,
        "age": ageCtrl.toString(),
        "address_id": addressId.toString()
      });

      rawDate = issuedOnCtrl.text.split('-');

      final ctcId = await addCtc({
        "ctc_number": ctcNumberCtrl.text,
        "ctc_dateissue": '${rawDate[2]}-${rawDate[0]}-${rawDate[1]}',
        "ctc_placeissue": issuedAtCtrl.text
      });

      final pccId = await addPcc(
        {'pcc_number': '-1', 'issued_date': DateTime.now().toString()},
      );

      addPccd({
        "pcc_id": pccId.toString(),
        "applicant_id": applicantId.toString(),
        "purpose_id": selectedPurpose.toString(),
        "ctc_id": ctcId.toString(),
        "police_id": "1",
        "oic_id": "1",
        "payment_id": "1",
        "status": "Pending Payment"
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignaturePanel(
            applicantId: applicantId!,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void updateForm(BuildContext context) async {
    try {
      final addressId =
          await editAddress(widget.applicant!.applicant.addressId, {
        'zone_name': selectedZone.toString(),
        'barangay_name': selectedBarangay.toString()
      });

      var rawDate = dateOfBirthCtrl.text.split('-');
      await editApplicant(widget.applicant!.applicant.id, {
        "first_name": firstNameCtrl.text,
        "middle_name": middleNameCtrl.text,
        "last_name": lastNameCtrl.text,
        "contact_no": contactCtrl.text,
        "date_of_birth": '${rawDate[2]}-${rawDate[0]}-${rawDate[1]}',
        "place_of_birth": placeOfBirthCtrl.text,
        "civil_status": selectcs,
        "height": heightCtrl.text,
        "sex": selectsex,
        "nationality": nationalityCtrl.text,
        "age": ageCtrl
            .toString(), //need to convert the age to string and need to add it for the generating in pccd certificate
        "address_id": addressId.toString()
      });

      rawDate = issuedOnCtrl.text.split('-');

      await editCtc(widget.applicant!.ctcId, {
        "ctc_number": ctcNumberCtrl.text,
        "ctc_dateissue": '${rawDate[2]}-${rawDate[0]}-${rawDate[1]}',
        "ctc_placeissue": issuedAtCtrl.text
      });

      // final pccId = await addPcc(
      //     {'pcc_number': '-1', 'issued_date': DateTime.now().toString()});

      editPccd(widget.applicant!.id, {
        "purpose_id": selectedPurpose.toString(),
      });
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  void validateForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      showLoaderDialog(context);
      if (widget.applicant == null) {
        saveNewForm(context);
      } else {
        updateForm(context);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Applicant'),
        backgroundColor: const Color.fromARGB(221, 8, 45, 211),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: SingleChildScrollView(
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: firstNameCtrl,
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
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: middleNameCtrl,
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
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: lastNameCtrl,
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
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment
                      .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text(
                    'Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),

                Row(
                  children: <Widget>[
                    if (zones.isNotEmpty)
                      Expanded(
                        child: DropdownButton(
                          hint: const Text('Zone'),
                          items: zones.map((itemoned) {
                            return DropdownMenuItem(
                              value: itemoned.id,
                              child: Text(itemoned.name.toString()),
                            );
                          }).toList(),
                          onChanged: (newvalue) {
                            setState(() {
                              selectedZone = newvalue as int;
                            });
                          },
                          value: selectedZone,
                        ),
                      ),
                    const SizedBox(width: 40),
                    if (cateogoryBarangayList.isNotEmpty)
                      Expanded(
                        child: DropdownButton(
                          hint: const Text('Barangay'),
                          items: cateogoryBarangayList.map((items) {
                            return DropdownMenuItem(
                              value: items.id,
                              child: Text(items.name.toString()),
                            );
                          }).toList(),
                          onChanged: (newvalue) {
                            setState(() {
                              selectedBarangay = newvalue as int;
                            });
                          },
                          value: selectedBarangay,
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
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: Align(
                        alignment: Alignment
                            .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          'Date of Birth',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: Align(
                        alignment: Alignment
                            .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          'Sex',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: placeOfBirthCtrl,
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
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: TextFormField(
                        controller: dateOfBirthCtrl,
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
                      ),
                    ),
                    const SizedBox(width: 40),
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
                            value: itemgen,
                            child: Text(itemgen),
                          );
                        }).toList(),
                      ),
                    ),
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
                          'Contact Number',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: Align(
                        alignment: Alignment
                            .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          'Civil Status',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
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
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: contactCtrl,
                        decoration: const InputDecoration(
                          labelText: "Contact Number",
                        ),
                        inputFormatters: [maskFormatter],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Contact Number";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
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
                            value: itemone,
                            child: Text(itemone),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: TextFormField(
                        controller: heightCtrl,
                        decoration: const InputDecoration(
                          labelText: "Height",
                        ),
                        inputFormatters: [heightFormatter],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Height";
                          } else {
                            return null;
                          }
                        },
                      ),
                    )
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
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Age',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: nationalityCtrl,
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
                    const SizedBox(width: 40),
                    Expanded(
                      child: TextFormField(
                        controller: ageCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Age";
                          } else {
                            return null;
                          }
                        },
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 16),

                const Align(
                  alignment: Alignment
                      .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text(
                    'Purpose',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: DropdownButton(
                        hint: const Text('Purpose'),
                        items: purposes.map((itemoned) {
                          return DropdownMenuItem(
                            value: itemoned.id,
                            child: Text(itemoned.name.toString()),
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            selectedPurpose = newvalue as int;
                          });
                        },
                        value: selectedPurpose,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: ctcNumberCtrl,
                        decoration: const InputDecoration(
                          labelText: "CTC Number",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input CTC Number";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: issuedOnCtrl,
                        decoration: const InputDecoration(
                          labelText: "Issued On (Month-Day-Year)",
                        ),
                        inputFormatters: [maskFormatter2],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Issued data";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: issuedAtCtrl,
                        decoration: const InputDecoration(
                          labelText: "Issued at",
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Input Issued at";
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
                    validateForm(context);
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
