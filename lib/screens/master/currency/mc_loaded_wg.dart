import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/models/currency_model.dart';
import 'package:thingy_app/routes/app_router.dart';

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
    Size mq = MediaQuery.of(context).size;
    List<DataColumn> cols = [
      DataColumn(
        onSort: (ind, asc) => sortColumn(ind, asc),
        label: const Expanded(
          child: Text('Symbol'),
        ),
      ),
      DataColumn(
        onSort: (ind, asc) => sortColumn(ind, asc),
        label: const Expanded(
          child: Text('Name'),
        ),
      ),
      DataColumn(
        onSort: (ind, asc) => sortColumn(ind, asc),
        label: const Expanded(
          child: Text('Native Symbol'),
        ),
      ),
      const DataColumn(
        label: Expanded(
          child: Text('Decimal Digits'),
        ),
      ),
      const DataColumn(
        label: Expanded(
          child: Text('Rounding'),
        ),
      ),
      DataColumn(
        onSort: (ind, asc) => sortColumn(ind, asc),
        label: const Expanded(
          child: Text('Code'),
        ),
      ),
      const DataColumn(
        label: Expanded(
          child: Text('Plural Name'),
        ),
      ),
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchText,
              onFieldSubmitted: (_) => searchList(),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Please fill your email' : null,
              decoration: InputDecoration(
                labelText: "Search...",
                hintText: "Find Currency...",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      crs = widget.curs;
                      searchText.text = '';
                    });
                  },
                  icon: const Icon(Icons.clear),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            mq.width <= Consts.wdt.sm
                ? SizedBox(
                    height: mq.height,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        CurrencyModel c = crs[index];
                        return ListTile(
                          onTap: () =>
                              context.router.push(MCEditRoute(mcId: c.id)),
                          leading: CircleAvatar(
                            child: Text(
                              c.symbol,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(c.name),
                          subtitle: Text(c.code),
                        );
                      },
                      itemCount: crs.length,
                    ),
                  )
                : LgView(
                    sortAsc: sortAsc,
                    sortIndex: sortIndex,
                    cols: cols,
                    crs: crs),
          ],
        ),
      ),
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
                  DataCell(Text(c.symbol)),
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
}
