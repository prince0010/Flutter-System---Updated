// import 'package:advanced_datatable/advanced_datatable_source.dart';
// import 'package:advanced_datatable/datatable.dart';
// import 'package:flutter/material.dart';
// import 'package:policesystem/model/user_model.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'User Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);
//   final String? title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
//   final source = ExampleSource();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title!),
//       ),
//       body: SingleChildScrollView(
//         child: AdvancedPaginatedDataTable(
//           addEmptyRows: false,
//           source: source,
//           showFirstLastButtons: true,
//           rowsPerPage: rowsPerPage,
//           availableRowsPerPage: [1, 5, 10, 50],
//           onRowsPerPageChanged: (newRowsPerPage) {
//             if (newRowsPerPage != null) {
//               setState(() {
//                 rowsPerPage = newRowsPerPage;
//               });
//             }
//           },
//           columns: [
//             DataColumn(label: Text('ID')),
//             DataColumn(label: Text('First Name')),
//             DataColumn(label: Text('Last Name')),
//             DataColumn(label: Text('Contact Number')),
//             DataColumn(label: Text('Userame'))
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RowData {
//   final int index;
//   final String value;

//   RowData(this.index, this.value);
// }

// class ExampleSource extends AdvancedDataTableSource<Users> {
//   final data =
//       List<Users>.generate(4, (id) => Users(index, 'Value for no. $id'));

//   @override
//   DataRow? getRow(int id) {
//     final currentRowData = lastDetails!.rows[id];
//     return DataRow(cells: [
//       DataCell(
//         Text(currentRowData.id.toString()),
//       ),
//       DataCell(
//         Text(currentRowData.first_name),
//       ),
//       DataCell(
//         Text(currentRowData.last_name),
//       ),
//       DataCell(
//         Text(currentRowData.contact_no),
//       ),
//       DataCell(
//         Text(currentRowData.username),
//       )
//     ]);
//   }

//   @override
//   int get selectedRowCount => 0;

//   @override
//   Future<RemoteDataSourceDetails<Users>> getNextPage(
//       NextPageRequest pageRequest) async {
//     return RemoteDataSourceDetails(
//       data.length,
//       data
//           .skip(pageRequest.offset)
//           .take(pageRequest.pageSize)
//           .toList(), //again in a real world example you would only get the right amount of rows
//     );
//   }
// }

import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:policesystem/api/user_api.dart';
import 'package:policesystem/model/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  final source = ExampleSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: FutureBuilder(
        future: null,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: AdvancedPaginatedDataTable(
                addEmptyRows: false,
                source: source,
                showFirstLastButtons: true,
                rowsPerPage: rowsPerPage,
                availableRowsPerPage: [1, 5, 10, 50],
                onRowsPerPageChanged: (newRowsPerPage) {
                  if (newRowsPerPage != null) {
                    setState(() {
                      rowsPerPage = newRowsPerPage;
                    });
                  }
                },
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('First Name')),
                  DataColumn(label: Text('Middle Name')),
                  DataColumn(label: Text('Last Name')),
                  DataColumn(label: Text('Contact Number')),
                  DataColumn(label: Text('Username'))
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

// class RowData {
//   final int id;
//   final String value;

//   RowData(this.id, this.value);
// }

class ExampleSource extends AdvancedDataTableSource<Users> {
  final data = List<Users>.generate(
      13,
      (index) => Users(
          id: 0,
          first_name: '',
          middle_name: '',
          last_name: '',
          contact_no: '',
          username: ''));

  @override
  DataRow? getRow(int index) {
    final currentRowData = lastDetails!.rows[index];
    return DataRow(cells: [
      DataCell(
        Text(currentRowData.id.toString()),
      ),
      DataCell(
        Text(currentRowData.first_name),
      ),
      DataCell(
        Text(currentRowData.middle_name),
      ),
      DataCell(
        Text(currentRowData.last_name),
      ),
      DataCell(
        Text(currentRowData.contact_no),
      ),
      DataCell(
        Text(currentRowData.username),
      ),
    ]);
  }

  @override
  int get selectedRowCount => 0;

  @override
  Future<RemoteDataSourceDetails<Users>> getNextPage(
      NextPageRequest pageRequest) {
    // TODO: implement getNextPage
    throw UnimplementedError();
  }

  // @override
  // Future<RemoteDataSourceDetails<Users>> getNextPage(
  //     NextPageRequest pageRequest) async {
  //   return RemoteDataSourceDetails(
  //     // data.length,
  //     // data
  //     //     .skip(pageRequest.offset)
  //     //     .take(pageRequest.pageSize)
  //     //     .toList(), //again in a real world example you would only get the right amount of rows
  //     // data.length,
  //     // (data.length as List<dynamic>)
  //     //     .map((e) => Users.fromPagedJson(e))
  //     //     .toList(),
  //   );
  // }
// }
}
