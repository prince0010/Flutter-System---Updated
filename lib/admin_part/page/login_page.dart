import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policesystem/admin_part/Field/genTextFormField.dart';
import 'package:policesystem/admin_part/Field/genloginandaddHeader.dart';

import 'add_info.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _conusername = TextEditingController();
  final _conpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getLoginandSignupHeader(
                  textitle: 'Login',
                ),
                getTextFormField(
                  controller: _conusername,
                  icon: Icon(Icons.person),
                  hintName: 'Username',
                  isObscureText: false, //45 min
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conpassword,
                  icon: Icon(Icons.lock),
                  hintName: 'Password',
                  isObscureText: true, //45 min
                ),
                // Image.asset(""),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                        onPressed: () {
                          //when we press this button we want to navigate to the pick_panel screen
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddInfo()));
//when we press this button we want to navigate to the pick_panel screen
                        },
                        child: Text(
                          "Add Admin Details", //After pag add himo dayon kag dashboard na naa ning admindetails na button og ui then I wala nimo ni sa login pero naa sya sa dashboard so pagopen kay naay update og pag i click ang add na button katong add_info.dartang ipagawas
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
