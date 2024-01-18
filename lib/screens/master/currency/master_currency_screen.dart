import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/currency_model.dart';
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
                        decoration:
                            const InputDecoration(label: Text("Search")),
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
                              leading: CircleAvatar(
                                  child: Text(currency.symbolNative)),
                              title: Text(currency.code),
                              subtitle: Text(currency.name),
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

  void _fecthPage(int pageKey) async {
    await MasterRepo()
        .getCurrencyPaged("?page=$pageKey&pageSize=${pageSize.toString()}")
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
      print(value);
    }).catchError((er) {
      print(er);
    });
  }
}
