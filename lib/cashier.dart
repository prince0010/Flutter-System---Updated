import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policesystem/cashier/cashier_panel/cashier_panel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  doWhenWindowReady(() {
    var initialSize = Size(900, 620);
    appWindow.size = initialSize;
    appWindow.minSize = initialSize;
  });
  await Window.initialize();
  await Window.setEffect(
    effect: WindowEffect.aero,
    color: Color.fromARGB(50, 0, 0, 0),
  );
  //TColor.fromARGB(49, 245, 30, 30)ffect i guess
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Police System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        backgroundColor: Colors.white,
        //   primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => CashierPanel(),
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:policesystem/cashier/cashier_model/cashier_model.dart';

// void main() => runApp(const MyApp());

// /// This is the main application widget.
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: MyStatelessWidget(),
//       ),
//     );
//   }
// }

// /// This is the stateless widget that the main application instantiates.
// class MyStatelessWidget extends StatefulWidget {
//   MyStatelessWidget({Key? key}) : super(key: key);

//   @override
//   _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
// }

// class _MyStatelessWidgetState extends State<MyStatelessWidget> {
//   late List<Payment> users;

//   List<Payment> usersFiltered = [];
//   TextEditingController controller = TextEditingController();
//   String _searchResult = '';

//   @override
//   void initState() {
//     super.initState();
//     usersFiltered = users;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           child: new ListTile(
//             leading: new Icon(Icons.search),
//             title: new TextField(
//                 controller: controller,
//                 decoration: new InputDecoration(
//                     hintText: 'Search', border: InputBorder.none),
//                 onChanged: (value) {
//                   setState(() {
//                     _searchResult = value;
//                     usersFiltered = users
//                         .where((user) => user.or_number.contains(_searchResult))
//                         .toList();
//                   });
//                 }),
//             trailing: new IconButton(
//               icon: new Icon(Icons.cancel),
//               onPressed: () {
//                 setState(() {
//                   controller.clear();
//                   _searchResult = '';
//                   usersFiltered = users;
//                 });
//               },
//             ),
//           ),
//         ),
//         DataTable(
//           columns: const <DataColumn>[
//             DataColumn(
//               label: Text(
//                 'ID',
//                 style: TextStyle(fontStyle: FontStyle.italic),
//               ),
//             ),
//             DataColumn(
//               label: Text(
//                 'OR Number',
//                 style: TextStyle(fontStyle: FontStyle.italic),
//               ),
//             ),
//           ],
//           rows: List.generate(
//             usersFiltered.length,
//             (index) => DataRow(
//               cells: <DataCell>[
//                 DataCell(Text(usersFiltered[index].id.toString())),
//                 DataCell(Text(usersFiltered[index].or_number))
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// /// This is the main application widget.
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: MyStatelessWidget(),
//       ),
//     );
//   }
// }

// class User {
//   String name;
//   int age;
//   String role;

//   User({required this.name, required this.age, required this.role});
// }

// /// This is the stateless widget that the main application instantiates.
// class MyStatelessWidget extends StatefulWidget {
//   MyStatelessWidget({Key? key}) : super(key: key);

//   @override
//   _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
// }

// class _MyStatelessWidgetState extends State<MyStatelessWidget> {
//   List<User> users = [
//     User(name: "Sarah", age: 19, role: "Student"),
//     User(name: "Janine", age: 43, role: "Professor")
//   ];
//   List<User> usersFiltered = [];
//   TextEditingController controller = TextEditingController();
//   String _searchResult = '';

//   @override
//   void initState() {
//     super.initState();
//     usersFiltered = users;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           child: new ListTile(
//             leading: new Icon(Icons.search),
//             title: new TextField(
//                 controller: controller,
//                 decoration: new InputDecoration(
//                     hintText: 'Search', border: InputBorder.none),
//                 onChanged: (value) {
//                   setState(() {
//                     _searchResult = value;
//                     // usersFiltered = users
//                     //     .where((user) =>
//                     //         user.name.contains(_searchResult) ||
//                     //         user.role.contains(_searchResult))
//                     //     .toList();
//                   });
//                 }),
//             trailing: new IconButton(
//               icon: new Icon(Icons.cancel),
//               onPressed: () {
//                 setState(() {
//                   controller.clear();
//                   _searchResult = '';
//                   usersFiltered = users;
//                 });
//               },
//             ),
//           ),
//         ),
//         DataTable(
//           columns: const <DataColumn>[
//             DataColumn(
//               label: Text(
//                 'Name',
//                 style: TextStyle(fontStyle: FontStyle.italic),
//               ),
//             ),
//             DataColumn(
//               label: Text(
//                 'Age',
//                 style: TextStyle(fontStyle: FontStyle.italic),
//               ),
//             ),
//             DataColumn(
//               label: Text(
//                 'Role',
//                 style: TextStyle(fontStyle: FontStyle.italic),
//               ),
//             ),
//           ],
//           rows: List.generate(
//             usersFiltered.length,
//             (index) => DataRow(
//               cells: <DataCell>[
//                 DataCell(Text(usersFiltered[index].name)),
//                 DataCell(Text(usersFiltered[index].age.toString())),
//                 DataCell(Text(usersFiltered[index].role)),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

