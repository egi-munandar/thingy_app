import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/cubit/item_cubit.dart';
import 'package:thingy_app/models/item_model.dart';
import 'package:toast/toast.dart';

class MitLoadedWidget extends StatefulWidget {
  final List<ItemModel> items;
  const MitLoadedWidget({super.key, required this.items});

  @override
  State<MitLoadedWidget> createState() => _MitLoadedWidgetState();
}

class _MitLoadedWidgetState extends State<MitLoadedWidget> {
  final searchText = TextEditingController();
  List<ItemModel> filteredItems = [];
  @override
  void initState() {
    filteredItems = widget.items;
    super.initState();
  }

  void searchList() {
    setState(() {
      filteredItems = widget.items
          .where((ItemModel it) =>
              it.name.toUpperCase().contains(searchText.text.toUpperCase()) ||
              it.serialNumber
                  .toUpperCase()
                  .contains(searchText.text.toUpperCase()) ||
              it.assetId.toUpperCase().contains(searchText.text.toUpperCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final mq = MediaQuery.of(context).size;
    final List<DataColumn> columns = [
      const DataColumn(label: Expanded(child: Text("Action"))),
      const DataColumn(label: Expanded(child: Text("Name"))),
      const DataColumn(label: Expanded(child: Text("SN"))),
      const DataColumn(label: Expanded(child: Text("Qty"))),
      const DataColumn(label: Expanded(child: Text("Description"))),
    ];
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: () => BlocProvider.of<ItemCubit>(context).getItems(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextFormField(
              controller: searchText,
              onFieldSubmitted: (_) => searchList(),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Please fill your email' : null,
              decoration: InputDecoration(
                labelText: "Search...",
                hintText: "Find Currency...",
                prefixIcon: mq.width > Consts.wdt.sm
                    ? IconButton(
                        onPressed: () =>
                            BlocProvider.of<ItemCubit>(context).getItems(),
                        icon: const Icon(Icons.refresh_rounded),
                        tooltip: "Refresh Data",
                      )
                    : null,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      filteredItems = widget.items;
                      searchText.text = '';
                    });
                  },
                  icon: const Icon(Icons.clear),
                  color: Theme.of(context).primaryColor,
                  tooltip: 'Clear Search',
                ),
              ),
            ),
            mq.width > Consts.wdt.sm
                ? lgView(columns, context)
                : SizedBox(
                    height: mq.height,
                  ),
          ]),
        ),
      ),
    );
  }

  SizedBox lgView(List<DataColumn> columns, BuildContext context) {
    final columns = [
      PlutoColumn(title: 'Name', field: 'name', type: PlutoColumnType.text()),
      PlutoColumn(
          title: 'Description',
          field: 'description',
          type: PlutoColumnType.text()),
    ];
    final List<PlutoRow> rows = [];
    Future<PlutoLazyPaginationResponse> fetchItems(
        PlutoLazyPaginationRequest request) async {
      String queryString = "?page=${request.page}";
      if (request.filterRows.isNotEmpty) {
        final filterMap = FilterHelper.convertRowsToMap(request.filterRows);
        for (final filter in filterMap.entries) {
          for (final type in filter.value) {
            queryString += "&filter[${filter.key}]";
            final filterType = type.entries.first;
            queryString += "[${filterType.key}][]=${filterType.value}";
          }
        }
      }

      if (request.sortColumn != null && !request.sortColumn!.sort.isNone) {
        queryString +=
            "&sort=${request.sortColumn!.field},${request.sortColumn!.sort.name}";
      }
      print(queryString);
      final dataFromServer = await Future.value("""{
        "totalPage":2,
        "data": [
          {
            "name": "Value1",
            "description":"Desc1"
          },
          {
            "name": "Value2",
            "description":"Desc2"
          },
          {
            "name": "Value3",
            "description":"Desc3"
          },
          {
            "name": "Value4",
            "description":"Desc4"
          },
          {
            "name": "Value5",
            "description":"Desc5"
          },
          {
            "name": "Value6",
            "description":"Desc6"
          },
          {
            "name": "Value7",
            "description":"Desc7"
          },
          {
            "name": "Value8",
            "description":"Desc8"
          },
          {
            "name": "Value9",
            "description":"Desc9"
          },
          {
            "name": "Value10",
            "description":"Desc10"
          },
          {
            "name": "Value11",
            "description":"Desc11"
          }
        ]
      }""");
      final parsedData = jsonDecode(dataFromServer);
      final rows = parsedData['data'].map<PlutoRow>((rowData) {
        return PlutoRow.fromJson(rowData);
      });
      return PlutoLazyPaginationResponse(
          totalPage: parsedData['totalPage'], rows: rows.toList());
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        createFooter: (stateManager) {
          return PlutoLazyPagination(
            fetch: fetchItems,
            stateManager: stateManager,
          );
        },
      ),
    );
  }
}
