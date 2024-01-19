import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/currency_model.dart';
import 'package:thingy_app/routes/app_router.dart';
import 'package:thingy_app/screens/app_drawer.dart';
import 'package:thingy_app/screens/loading_screen.dart';

@RoutePage()
class MasterCurrencyScreen extends StatefulWidget {
  const MasterCurrencyScreen({super.key});

  @override
  State<MasterCurrencyScreen> createState() => _MasterCurrencyScreenState();
}

class _MasterCurrencyScreenState extends State<MasterCurrencyScreen> {
  bool isLoading = false;
  static const pageSize = 20;
  final PagingController<int, CurrencyModel> pgCont =
      PagingController<int, CurrencyModel>(firstPageKey: 1);
  final TextEditingController searchBox = TextEditingController();
  @override
  void initState() {
    pgCont.addPageRequestListener((pageKey) {
      _fecthPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    pgCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CURRENCY")),
      drawer: const AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushRoute(
            McAddRoute(onResult: (v) => v ? pgCont.refresh() : null)),
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const LoadingScreen()
          : LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onFieldSubmitted: (v) => pgCont.refresh(),
                        textInputAction: TextInputAction.search,
                        controller: searchBox,
                        decoration: InputDecoration(
                            label: const Text("Search"),
                            suffixIcon: IconButton(
                                onPressed: () => pgCont.refresh(),
                                icon: const Icon(Icons.send))),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        child: PagedListView(
                          pagingController: pgCont,
                          padding: const EdgeInsets.all(8.0),
                          builderDelegate:
                              PagedChildBuilderDelegate<CurrencyModel>(
                                  itemBuilder: (context, currency, index) {
                            return ListTile(
                              onTap: () {
                                context.router
                                    .push(McDetailRoute(currency: currency));
                              },
                              leading: CircleAvatar(
                                  child: Text(currency.symbolNative)),
                              title: Text(currency.code),
                              subtitle: Text(currency.name),
                              trailing: PopupMenuButton<String>(
                                onSelected: (val) {
                                  switch (val) {
                                    case 'Edit':
                                      context.router.push(McEditRoute(
                                          currency: currency,
                                          onResult: (v) =>
                                              v ? pgCont.refresh() : null));
                                      break;
                                    case 'Delete':
                                      deleteCur(context, currency);
                                      break;
                                  }
                                },
                                itemBuilder: (context) {
                                  return {"Edit", "Delete"}.map((String c) {
                                    return PopupMenuItem(
                                        value: c, child: Text(c));
                                  }).toList();
                                },
                              ),
                            );
                          }),
                        ),
                        onRefresh: () => Future.sync(
                          () => pgCont.refresh(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _fecthPage(
    int pageKey,
  ) async {
    await MasterRepo()
        .getCurrencyPaged(
            "?page=$pageKey&pageSize=${pageSize.toString()}&filter=${searchBox.text}")
        .then((value) {
      final List<CurrencyModel> newItems = [];
      for (var c in value['data']) {
        CurrencyModel cur = CurrencyModel.fromMap(c);
        newItems.add(cur);
      }
      if (value['totalPage'] == pageKey) {
        //last page
        pgCont.appendLastPage(newItems);
      } else {
        pgCont.appendPage(newItems, pageKey + 1);
      }
    }).catchError((er) {
      Fluttertoast.showToast(msg: er.toString());
    });
  }

  Future<void> deleteCur(BuildContext context, CurrencyModel currency) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Delete Currency?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text("${currency.name} (${currency.code})"),
        actions: [
          TextButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await MasterRepo().deleteCurrency(currency.id).then((_) {
                Fluttertoast.showToast(msg: "Currency Deleted");
                Navigator.pop(ctx);
                pgCont.refresh();
              });
              setState(() {
                isLoading = false;
              });
            },
            child: const Text(
              "YES",
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("NO"),
          ),
        ],
      ),
    );
  }
}
