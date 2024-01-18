import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/currency_model.dart';

class McLvWg extends StatefulWidget {
  const McLvWg({super.key});

  @override
  State<McLvWg> createState() => _McLvWgState();
}

class _McLvWgState extends State<McLvWg> {
  static const pageSize = 20;
  final PagingController<int, CurrencyModel> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final itms = await MasterRepo()
          .getCurrencyPaged("?page=$pageKey&pageSize=$pageSize");
      final List<CurrencyModel> newItems = [];
      for (var c in itms['data']) {
        CurrencyModel cur = CurrencyModel.fromMap(c);
        newItems.add(cur);
      }
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => _pagingController.refresh()),
      child: PagedListView(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CurrencyModel>(
            itemBuilder: (context, item, index) {
          return ListTile(
            leading: CircleAvatar(child: Text(item.symbolNative)),
            title: Text(item.name),
            subtitle: Text(item.code),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
