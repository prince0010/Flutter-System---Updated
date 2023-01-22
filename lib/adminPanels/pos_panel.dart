import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:policesystem/admin_component/menu.dart';
import 'package:policesystem/admin_component/floating_action_button_components.dart';
import 'package:policesystem/api/pos_panel_api.dart';
import 'package:policesystem/cashier/cashier_components/search_comp.dart';
import 'package:policesystem/model/pos_model.dart';
import 'package:policesystem/user_panel/positions_form.dart';
import 'package:policesystem/user_panel/rank_form.dart';

class Pospanel extends StatefulWidget {
  const Pospanel({Key? key}) : super(key: key);

  @override
  _PospanelState createState() => _PospanelState();
}

class _PospanelState extends State<Pospanel> {
  final isDialOpen = ValueNotifier(false);
  ItemPager pager = ItemPager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Positions Table'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.login_rounded),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 18, 79, 103),
      ),
      body: FutureBuilder(
        future: fetchPositions(),
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
                  header: const Text(
                    'Position Table',
                  ),
                  rowsPerPage: 10,
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name'))
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
              label: 'Add Position',
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PositionForm()))
                    .then((value) {
                  setState(() {});
                });
              },
              backgroundColor: Colors.orange),
        ],
      ),
    );
  }

  DataTableSource dataSource(List<Positions> positionsList) =>
      MyData(dataList: positionsList);
}

class MyData extends DataTableSource {
  MyData({required this.dataList});
  late final List<Positions> dataList;
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
      //Data cells display
      cells: [
        DataCell(
          Text(dataList[index].id.toString()),
          //  onTap: DetailPage(invoice: invoice),
        ),
        DataCell(
          Text(dataList[index].name),
        ),
      ],
    );
  }
}
