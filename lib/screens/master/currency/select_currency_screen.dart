import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/currency_model.dart';

@RoutePage()
class SelectCurrencyScreen extends StatefulWidget {
  const SelectCurrencyScreen({super.key, required this.onSelect});
  final Function(CurrencyModel? currency) onSelect;
  @override
  State<SelectCurrencyScreen> createState() => _SelectCurrencyScreenState();
}

class _SelectCurrencyScreenState extends State<SelectCurrencyScreen> {
  static const pageSize = 20;
  final TextEditingController searchBox = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Currency")),
      body: LayoutBuilder(
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
                    builderDelegate: PagedChildBuilderDelegate<CurrencyModel>(
                        itemBuilder: (context, currency, index) {
                      return ListTile(
                        onTap: () {
                          widget.onSelect(currency);
                          context.popRoute();
                        },
                        leading:
                            CircleAvatar(child: Text(currency.symbolNative)),
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
}
