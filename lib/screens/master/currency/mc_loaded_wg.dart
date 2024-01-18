import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/cubit/currency_cubit.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/currency_model.dart';
import 'package:thingy_app/routes/app_router.dart';
import 'package:thingy_app/screens/master/currency/mc_lv_wg.dart';
import 'package:toast/toast.dart';

class MCLoadedWg extends StatefulWidget {
  final List<CurrencyModel> curs;
  const MCLoadedWg({super.key, required this.curs});

  @override
  State<MCLoadedWg> createState() => _MCLoadedWgState();
}

class _MCLoadedWgState extends State<MCLoadedWg> {
  List<CurrencyModel> crs = [];
  bool isLoading = false;
  final searchText = TextEditingController();
  int sortIndex = 0;
  bool sortAsc = true;
  @override
  void initState() {
    crs = widget.curs;
    super.initState();
  }

  void sortColumn(int index, bool asc) {
    setState(() {
      sortIndex = index;
      sortAsc = asc;
      onSortColumn(index, asc);
    });
  }

  void searchList() {
    setState(() {
      crs = widget.curs
          .where((CurrencyModel e) => (e.name
                  .toUpperCase()
                  .contains(searchText.text.toUpperCase()) ||
              e.code.toUpperCase().contains(searchText.text.toUpperCase()) ||
              e.symbol.toUpperCase().contains(searchText.text.toUpperCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    Size mq = MediaQuery.of(context).size;
    return mq.width <= Consts.wdt.sm ? const McLvWg() : plutoTbl(context);
  }

  Column oldSmView(Size mq, BuildContext context) {
    return Column(
      children: [
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
                        BlocProvider.of<CurrencyCubit>(context).getCurrencies(),
                    icon: const Icon(Icons.refresh_rounded),
                    tooltip: "Refresh Data",
                  )
                : null,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  crs = widget.curs;
                  searchText.text = '';
                });
              },
              icon: const Icon(Icons.clear),
              color: Theme.of(context).primaryColor,
              tooltip: 'Clear Search',
            ),
          ),
        ),
        SizedBox(
          height: mq.height,
          child: ListView.builder(
            itemBuilder: (context, index) {
              CurrencyModel c = crs[index];
              return ListTile(
                onLongPress: () => deleteCurr(context, c),
                onTap: () {
                  context.router.push(MCEditRoute(
                      mcId: c.id,
                      updated: (u) {
                        if (u) {
                          BlocProvider.of<CurrencyCubit>(context)
                              .getCurrencies();
                        }
                      }));
                },
                leading: CircleAvatar(
                  child: Text(
                    c.symbol,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(c.name),
                subtitle: Text(c.code),
              );
            },
            itemCount: crs.length,
          ),
        ),
      ],
    );
  }

  void onSortColumn(int index, bool asc) {
    switch (index) {
      case 0:
        if (asc) {
          crs.sort((a, b) => a.symbol.compareTo(b.symbol));
        } else {
          crs.sort((a, b) => b.symbol.compareTo(a.symbol));
        }
        break;
      case 1:
        if (asc) {
          crs.sort((a, b) => a.name.compareTo(b.name));
        } else {
          crs.sort((a, b) => b.name.compareTo(a.name));
        }
        break;
      case 2:
        if (asc) {
          crs.sort((a, b) => a.symbolNative.compareTo(b.symbolNative));
        } else {
          crs.sort((a, b) => b.symbolNative.compareTo(a.symbolNative));
        }
        break;
      case 5:
        if (asc) {
          crs.sort((a, b) => a.code.compareTo(b.code));
        } else {
          crs.sort((a, b) => b.code.compareTo(a.code));
        }
        break;
      default:
    }
  }

  Future<void> deleteCurr(BuildContext context, CurrencyModel curr) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog.adaptive(
        title: const Text(
          "Delete currency?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text("${curr.symbol} ${curr.name}"),
        actions: [
          TextButton(
              onPressed: () async {
                await MasterRepo().deleteCurrency(curr.id).then((_) {
                  BlocProvider.of<CurrencyCubit>(ctx).getCurrencies();
                  Toast.show("Currency Deleted!", duration: 2);
                  Navigator.pop(ctx);
                }).catchError((er) {
                  Consts().errDialog(ctx, er);
                });
              },
              child: const Text(
                "YES",
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text("NO")),
        ],
      ),
    );
  }

  SizedBox plutoTbl(BuildContext context) {
    final columns = [
      PlutoColumn(
        title: 'Symbol',
        field: 'symbol',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(title: 'Name', field: 'name', type: PlutoColumnType.text()),
      PlutoColumn(
          title: 'Native Symbol',
          field: 'symbolNative',
          type: PlutoColumnType.text()),
      PlutoColumn(
          title: 'Decimal Digits',
          field: 'decimalDigits',
          type: PlutoColumnType.number()),
      PlutoColumn(
          title: 'Rounding', field: 'rounding', type: PlutoColumnType.number()),
      PlutoColumn(title: 'Code', field: 'code', type: PlutoColumnType.text()),
      PlutoColumn(
          title: 'Plural Name',
          field: 'namePlural',
          type: PlutoColumnType.text()),
    ];
    final List<PlutoRow> rows = [];
    List<CurrencyModel> curItems = [];

    Future<PlutoLazyPaginationResponse> fetchCurs(
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
        String srt = request.sortColumn!.sort.isAscending ? 'asc' : 'desc';
        queryString += "&sort=${request.sortColumn!.field},$srt";
      }
      final Map<String, dynamic> dataFromServer =
          await MasterRepo().getCurrencyPaged(queryString);
      final rows = dataFromServer['data']
          .map<PlutoRow>((rowData) => PlutoRow.fromJson(rowData));
      List<CurrencyModel> ci = [];
      for (var val in dataFromServer['data']) {
        ci.add(CurrencyModel.fromMap(val));
      }
      setState(() {
        curItems = ci;
      });
      print(queryString);
      return PlutoLazyPaginationResponse(
          totalPage: dataFromServer['totalPage'], rows: rows.toList());
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: PlutoGrid(
        mode: PlutoGridMode.selectWithOneTap,
        columns: columns,
        configuration: PlutoGridConfiguration(
            style: PlutoGridStyleConfig(
                gridBorderRadius: BorderRadius.circular(10))),
        onSelected: (e) {
          final CurrencyModel c = curItems[e.rowIdx!];
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog.adaptive(
                    title: Text(c.name),
                    content: Text(e.cell!.value),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            context.router.push(MCEditRoute(
                                mcId: c.id,
                                updated: (u) {
                                  if (u) {
                                    BlocProvider.of<CurrencyCubit>(context)
                                        .getCurrencies();
                                  }
                                }));
                            Navigator.pop(ctx);
                          },
                          icon: const Icon(Icons.edit_rounded),
                          color: Colors.amber,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          deleteCurr(ctx, c);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                      IconButton(
                        onPressed: () async {
                          await Clipboard.setData(
                                  ClipboardData(text: e.cell!.value))
                              .then((value) {
                            Navigator.pop(ctx);
                          });
                          Toast.show("${e.cell!.value} copied to clipboard",
                              duration: 3);
                        },
                        icon: const Icon(Icons.copy),
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ));
        },
        rows: rows,
        createFooter: (stateManager) =>
            PlutoLazyPagination(fetch: fetchCurs, stateManager: stateManager),
      ),
    );
  }
}

class LgView extends StatelessWidget {
  const LgView({
    super.key,
    required this.sortAsc,
    required this.sortIndex,
    required this.cols,
    required this.crs,
  });

  final bool sortAsc;
  final int sortIndex;
  final List<DataColumn> cols;
  final List<CurrencyModel> crs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        sortAscending: sortAsc,
        sortColumnIndex: sortIndex,
        columns: cols,
        rows: crs
            .map((CurrencyModel c) => DataRow(cells: [
                  DataCell(Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            context.router.push(MCEditRoute(
                                mcId: c.id,
                                updated: (u) {
                                  if (u) {
                                    BlocProvider.of<CurrencyCubit>(context)
                                        .getCurrencies();
                                  }
                                }));
                          },
                          icon: const Icon(Icons.edit_rounded),
                          color: Colors.amber,
                        ),
                      ),
                      IconButton(
                        onPressed: () => deleteCurr(context, c),
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      )
                    ],
                  )),
                  DataCell(
                    Text(c.symbol),
                  ),
                  DataCell(Text(c.name)),
                  DataCell(Text(c.symbolNative)),
                  DataCell(Text(c.decimalDigits.toString())),
                  DataCell(Text(c.rounding.toString())),
                  DataCell(Text(c.code)),
                  DataCell(Text(c.namePlural)),
                ]))
            .toList(),
      ),
    );
  }

  Future<void> deleteCurr(BuildContext context, CurrencyModel curr) async {
    showDialog(
      context: context,
      builder: (BuildContext dcCtx) => AlertDialog.adaptive(
        title: const Text(
          "Delete currency?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text("${curr.symbol} ${curr.name}"),
        actions: [
          TextButton(
              onPressed: () async {
                await MasterRepo().deleteCurrency(curr.id).then((_) {
                  BlocProvider.of<CurrencyCubit>(context).getCurrencies();
                  Toast.show("Currency Deleted!", duration: 2);
                  Navigator.pop(dcCtx);
                }).catchError((er) {
                  Consts().errDialog(dcCtx, er);
                });
              },
              child: const Text(
                "YES",
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () => Navigator.pop(dcCtx), child: const Text("NO")),
        ],
      ),
    );
  }
}