import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class data_rows extends StatelessWidget {
  @override
  data_rows(
      {required this.id,
      required this.firstname,
      required this.middlename,
      required this.lastname,
      required this.address,
      required this.contact_no});
  late String id, firstname, middlename, lastname, address, contact_no;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return data_rows(
        id: id,
        firstname: firstname,
        middlename: middlename,
        lastname: lastname,
        address: address,
        contact_no: contact_no);
  }
}
