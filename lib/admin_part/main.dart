import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policesystem/admin_part/Model/userModel.dart';
import 'package:policesystem/admin_part/page/add_info.dart';
import 'package:policesystem/admin_part/page/dashboard.dart';
import 'package:policesystem/admin_part/services/userService.dart';

import 'page/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Window.initialize();
  await Window.setEffect(
    effect: WindowEffect.aero,
    color: const Color.fromARGB(50, 0, 0, 0),
  );
  //This is for the window app effect i guess
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Police Issuance System',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        //   primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<UserModel> _userList;
  // final _userService = UserService();

  // getAllUserDetails() async {
  //   var users = await _userService.readAllUsers();
  //   _userList = <UserModel>[];

  //   users.forEach((user) {
  //     var userModel = UserModel();
  //     userModel.full_name = user['full_name'];
  //     userModel.username = user['username'];
  //     userModel.password = user['password'];
  //     userModel.address = user['address'];
  //     userModel.phone_num = user['phone_num'];

  //     _userList.add(userModel);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD"),
      ),
      body: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(_userList[index].full_name ?? ''),
                subtitle: Text(_userList[index].username ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, color: Colors.teal),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddInfo()))
              .then((data) {
            // if (data != null) {
            //   getAllUserDetails();
            // }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
