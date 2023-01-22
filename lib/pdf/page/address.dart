import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:policesystem/pdf/model/address.dart';
import 'package:policesystem/pdf/page/details.dart';

class PoliceHeader extends StatelessWidget {
  PoliceHeader({Key? key}) : super(key: key);

  final address = <Address>[
    Address(
      policestation: 'EL SALVADOR POLICE STATION',
      address: 'POBLACION, EL SALVADOR CITY, MISAMIS ORIENTAL',
      number: '(088) 555-0317 / 0975-119-8833',
      email: 'elsalvador_pnp@yahoo.com',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Address'),
    ));
  }
}
