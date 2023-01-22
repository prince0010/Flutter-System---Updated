import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:policesystem/adminPanels/main_panel.dart';
import 'package:policesystem/api/rank_panel_api.dart';
import 'package:policesystem/model/ranks_model.dart';
import 'package:policesystem/model/user_item.dart';
import 'package:policesystem/user_panel/rank_form.dart';

class RanksPanel extends StatefulWidget {
  const RanksPanel({super.key});

  @override
  State<RanksPanel> createState() => _RanksPanelState();
}

class _RanksPanelState extends State<RanksPanel> {
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return MainPanel(
      title: 'Ranks',
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
              label: 'Add Rank',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RankForm())).then((value) {
                  setState(() {});
                });
              },
              backgroundColor: Colors.orange),
        ],
      ),
      child: FutureBuilder(
        future: fetchRanks(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
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
                    list: snapshot.data,
                  ),
                  header: const Text(
                    'Users Data Table',
                  ),
                  rowsPerPage: 10,
                  columns: [
                    'ID',
                    'Name',
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
  required List<Ranks> list,
}) =>
    RanksData(dataList: list);

class RanksData extends DataTableSource {
  RanksData({required this.dataList});
  late final List<Ranks> dataList;

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
          Text(dataList[index].name),
        ),
      ],
    );
  }
}
