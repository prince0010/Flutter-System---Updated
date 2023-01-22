import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:policesystem/admin_component/menu.dart';
import 'package:policesystem/api/police_api.dart';
import 'package:policesystem/admin_component/floating_action_button_components.dart';
import 'package:policesystem/admin_component/list_view_component.dart';
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/police_model.dart';
import 'package:policesystem/api/cr_panel_api.dart';
import 'package:policesystem/cashier/cashier_components/search_comp.dart';
import 'package:policesystem/model/cr_model.dart';
import 'package:policesystem/user_panel/barangay_form.dart';
import 'package:policesystem/user_panel/cr_form.dart';

class CrPanel extends StatefulWidget {
  const CrPanel({Key? key}) : super(key: key);

  @override
  _CrPanelState createState() => _CrPanelState();
}

class _CrPanelState extends State<CrPanel> {
  final isDialOpen = ValueNotifier(false);
  ItemPager pager = ItemPager();
  @override
  Widget build(BuildContext context) {
    //floating action button
    onWillPop:
    () async {
      if (isDialOpen.value) {
        //close speed dial
        isDialOpen.value = false;

        return false;
      } else {
        return true;
      }
    };
    //======

    return Scaffold(
      appBar: AppBar(
        title: Text('Criminal Records Table'),
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
        future: fetchCr(),
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
                    'Criminal Records Table',
                  ),
                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('First Name')),
                    DataColumn(label: Text('Middle Name')),
                    DataColumn(label: Text('Last Name')),
                  ],
                  showCheckboxColumn: false,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
      drawer: const Drawer(
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
              label: 'Add Criminical Record',
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CriminalForm()))
                    .then((value) {
                  setState(() {});
                });
              },
              backgroundColor: Colors.orange),
        ],
      ),
    );
  }

  DataTableSource dataSource(List<Cr> crList) => MyData(crdataList: crList);
}

class MyData extends DataTableSource {
  MyData({required this.crdataList});
  late final List<Cr> crdataList;
  //pagination
  int _selectedCount = 0;

  // late List<Police> _rows;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => crdataList.length;
  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= crdataList.length) return null;
    final row = crdataList[index];
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
          Text(crdataList[index].id.toString()),
        ),
        DataCell(
          Text(crdataList[index].first_name),
        ),
        DataCell(
          Text(crdataList[index].middle_name),
        ),
        DataCell(
          Text(crdataList[index].last_name),
        ),
      ],
    );
  }
}
