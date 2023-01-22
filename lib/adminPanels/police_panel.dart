import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:policesystem/admin_component/menu.dart';
import 'package:policesystem/api/police_api.dart';
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/police_model.dart';
import 'package:policesystem/cashier/cashier_components/search_comp.dart';
import 'package:policesystem/user_panel/police_form.dart';

class Policepanel extends StatefulWidget {
  const Policepanel({Key? key}) : super(key: key);

  @override
  _PolicepanelState createState() => _PolicepanelState();
}

class _PolicepanelState extends State<Policepanel> {
  final isDialOpen = ValueNotifier(false);
  ItemPager pager = ItemPager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Police Tables'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 18, 79, 103),
      ),
      body: FutureBuilder(
        future: fetchPolice(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                PaginatedSearchBar<Item>(
                  maxHeight: 30,
                  hintText: 'Search',
                  onSearch: ({
                    required pageIndex,
                    required pageSize,
                    required searchQuery,
                  }) async {
                    return Future.delayed(const Duration(milliseconds: 1300),
                        () {
                      if (searchQuery == "empty") {
                        return [];
                      }

                      return pager.next();
                    });
                  },
                  itemBuilder: (
                    context, {
                    required item,
                    required index,
                  }) {
                    return Text(item.title);
                  },
                ),
                PaginatedDataTable(
                  source: dataSource(snapshot.data),
                  header: Text(
                    'Police Data Table',
                  ),
                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('First Name')),
                    DataColumn(label: Text('Middle Name')),
                    DataColumn(label: Text('Last Name')),
                    DataColumn(label: Text('Contact Number')),
                    DataColumn(label: Text('Rank')),
                    DataColumn(label: Text('Position')),
                  ],
                  showCheckboxColumn: true,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
      drawer: Drawer(
        //====Navigation Bar====
        child: AdminMenu(),
      ),
      floatingActionButton: SpeedDial(
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
              label: 'Add Police',
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PoliceForm()))
                    .then((value) {
                  setState(() {});
                });
              },
              backgroundColor: Colors.orange),
        ],
      ),
    );
  }

  DataTableSource dataSource(List<Police> policeList) =>
      MyData(dataList: policeList);
}

class MyData extends DataTableSource {
  MyData({required this.dataList});
  late final List<Police> dataList;
  int _selectedCount = 0;

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
    final row = dataList[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      //  return DataRow(
      cells: [
        DataCell(
          Text(dataList[index].id.toString()),
        ),
        DataCell(
          Text(dataList[index].first_name),
        ),
        DataCell(
          Text(dataList[index].middle_name),
        ),
        DataCell(
          Text(dataList[index].last_name),
        ),
        DataCell(
          Text(dataList[index].contact_no),
        ),
        DataCell(
          Text(dataList[index].rank ?? ''),
        ),
        DataCell(
          Text(dataList[index].position ?? ''),
        ),
      ],
    );
  }
}
