import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:policesystem/adminPanels/main_panel.dart';
import 'package:policesystem/api/user_api.dart';
import 'package:policesystem/model/user_item.dart';
import 'package:policesystem/user_panel/user_form.dart';

class UsersPanel extends StatefulWidget {
  const UsersPanel({super.key});

  @override
  State<UsersPanel> createState() => _UsersPanelState();
}

class _UsersPanelState extends State<UsersPanel> {
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return MainPanel(
      title: 'Users',
      floatingAction: SpeedDial(
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 12,
        icon: Icons.share,
        spaceBetweenChildren: 12,
        closeManually:
            false, // This is for floating action button if manag click sa childer mu close siya
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.add),
              label: 'Add User',
              onTap: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserForm()))
                    .then((value) => setState(() {}));
              },
              backgroundColor: Colors.orange),
        ],
      ),
      child: FutureBuilder(
        future: fetchUsers(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<UserItem> filteredData = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                PaginatedSearchBar<UserItem>(
                  maxHeight: 30,
                  hintText: 'Search',
                  onSearch: ({
                    required pageIndex,
                    required pageSize,
                    required searchQuery,
                  }) async {
                    return [];
                  },
                  itemBuilder: (
                    context, {
                    required item,
                    required index,
                  }) {
                    return const SizedBox();
                  },
                ),
                PaginatedDataTable(
                  source: dataSource(
                      list: filteredData,
                      onDelete: (userItem) {
                        deleteUser(userItem.id).then((value) {
                          if (value != null && value) {
                            setState(() {});
                          }
                        });
                      }),
                  header: const Text(
                    'Users Data Table',
                  ),
                  rowsPerPage: 10,
                  columns: [
                    'ID',
                    'First Name',
                    'Middle Name',
                    'Last Name',
                    'Contact Number',
                    'Username',
                    ''
                  ].map((e) => DataColumn(label: Text(e))).toList(),
                ),
              ],
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

DataTableSource dataSource({
  required List<UserItem> list,
  required void Function(UserItem userItem) onDelete,
}) =>
    UsersData(dataList: list, onDelete: onDelete);

class UsersData extends DataTableSource {
  UsersData({required this.dataList, required this.onDelete});
  late final List<UserItem> dataList;
  late void Function(UserItem userItem) onDelete;

  // late List<Police> _rows;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => dataList.length;
  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= dataList.length) return null;

    return DataRow.byIndex(
      index: index,
      //  return DataRow(
      cells: [
        DataCell(
          Text(dataList[index].id.toString()),
        ),
        DataCell(
          Text(dataList[index].firstName),
        ),
        DataCell(
          Text(dataList[index].middleName),
        ),
        DataCell(
          Text(dataList[index].lastName),
        ),
        DataCell(
          Text(dataList[index].contactNo),
        ),
        DataCell(
          Text(dataList[index].username),
        ),
        DataCell(IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            onDelete(dataList[index]);
          },
        )),
      ],
    );
  }
}
