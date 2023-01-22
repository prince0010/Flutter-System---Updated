// import 'package:flutter/material.dart';
// import 'package:policesystem/admin_api/police_api.dart';
// import 'package:policesystem/admin_model/police_model.dart';

// class Policepanel extends StatefulWidget {
//   const Policepanel({Key? key}) : super(key: key);

//   @override
//   _PolicepanelState createState() => _PolicepanelState();
// }

// class _PolicepanelState extends State<Policepanel> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Police Data Table'),
//       ),
//       body: FutureBuilder(
//         future: fetchPolice(),
//         builder: (BuildContext ctx, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             return SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: PaginatedDataTable(
//                 source: dataSource(snapshot.data),
//                 header: const Text('Users'),
//                 columns: const [
//                   DataColumn(label: Text('ID')),
//                   DataColumn(label: Text('First Name')),
//                   DataColumn(label: Text('Middle Name')),
//                   DataColumn(label: Text('Last Name')),
//                   DataColumn(label: Text('Contact Number')),
//                 ],
//                 showCheckboxColumn: false,
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }

//           // By default, show a loading spinner.
//           return const CircularProgressIndicator();
//         },
//       ),
//     );
//   }

//   DataTableSource dataSource(List<Police> employeesList) =>
//       MyData(dataList: employeesList);
// }

// class MyData extends DataTableSource {
//   MyData({required this.dataList});
//   final List<Police> dataList;
//   // Generate some made-up data

//   @override
//   bool get isRowCountApproximate => false;
//   @override
//   int get rowCount => dataList.length;
//   @override
//   int get selectedRowCount => 0;
//   @override
//   DataRow getRow(int index) {
//     return DataRow(
//       cells: [
//         DataCell(
//           Text(dataList[index].id.toString()),
//         ),
//         DataCell(
//           Text(dataList[index].first_name),
//         ),
//         DataCell(
//           Text(dataList[index].middle_name),
//         ),
//         DataCell(
//           Text(dataList[index].last_name),
//         ),
//         DataCell(
//           Text(dataList[index].contact_no),
//         ),
//       ],
//     );
//   }
// }
