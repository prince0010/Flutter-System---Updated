import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:policesystem/api/payment_api.dart';
import 'package:policesystem/api/pcc_api.dart';
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/police_clearance_details.dart';
import 'package:policesystem/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key, required this.applicant});

  final PoliceClearanceDetails applicant;

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController orCtrl = TextEditingController();
  TextEditingController paymentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void validateForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      showLoaderDialog(context);
      final prefs = await SharedPreferences.getInstance();
      final User user = User.fromJson(json.decode(prefs.getString('user')!));

      // if (widget.applicant == null) {
      //   saveNewForm(context);
      // } else {
      //   updateForm(context);
      // }

      final paymentId = await addPayment({
        'or_number': orCtrl.text.toString(),
        'payment': paymentCtrl.text.toString(),
        'user_id': user.id.toString(),
      });
      await editPccd(widget.applicant.id, {
        'payment_id': paymentId.toString(),
      });

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
          centerTitle: false,
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: orCtrl,
                          decoration: const InputDecoration(
                            labelText: "OR Number",
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[0-9]*$').hasMatch(value)) {
                              return "Input valid OR Number";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: paymentCtrl,
                          decoration: const InputDecoration(
                            labelText: "Payment",
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[0-9]*$').hasMatch(value)) {
                              return "Input Payment";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          validateForm(context);
                        },
                        child: const Text('Confirm'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ));
  }
}
