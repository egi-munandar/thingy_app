import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/cubit/instance_cubit.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/instance_model.dart';
import 'package:thingy_app/routes/app_router.dart';
import 'package:toast/toast.dart';

class MiLoadedWg extends StatefulWidget {
  final List<InstanceModel> instances;
  const MiLoadedWg({super.key, required this.instances});

  @override
  State<MiLoadedWg> createState() => _MiLoadedWgState();
}

class _MiLoadedWgState extends State<MiLoadedWg> {
  final searchText = TextEditingController();
  List<InstanceModel> filteredInstances = [];
  @override
  void initState() {
    filteredInstances = widget.instances;
    super.initState();
  }

  void searchList() {
    setState(() {
      filteredInstances = widget.instances
          .where((InstanceModel e) =>
              e.name.toUpperCase().contains(searchText.text.toUpperCase()) ||
              e.currency.toUpperCase().contains(searchText.text.toUpperCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final mq = MediaQuery.of(context).size;
    final List<DataColumn> columns = [
      const DataColumn(
        label: Expanded(
          child: Text("Action"),
        ),
      ),
      const DataColumn(
        label: Expanded(
          child: Text("Name"),
        ),
      ),
      const DataColumn(
        label: Expanded(
          child: Text("Currency"),
        ),
      ),
      const DataColumn(
        label: Expanded(
          child: Text("Currency Symbol"),
        ),
      ),
      const DataColumn(
        label: Expanded(
          child: Text("Currency Code"),
        ),
      ),
    ];
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: () => BlocProvider.of<InstanceCubit>(context).getInstances(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: searchText,
                onFieldSubmitted: (_) => searchList(),
                validator: (val) => val == null || val.isEmpty
                    ? 'Please fill your email'
                    : null,
                decoration: InputDecoration(
                  labelText: "Search...",
                  hintText: "Find Currency...",
                  prefixIcon: mq.width > Consts.wdt.sm
                      ? IconButton(
                          onPressed: () =>
                              BlocProvider.of<InstanceCubit>(context)
                                  .getInstances(),
                          icon: const Icon(Icons.refresh_rounded),
                          tooltip: "Refresh Data",
                        )
                      : null,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        filteredInstances = widget.instances;
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
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          InstanceModel inst = filteredInstances[index];
                          return ListTile(
                            onTap: () {
                              context.router.push(
                                MiEditRoute(
                                    updated: (u) => u
                                        ? BlocProvider.of<InstanceCubit>(
                                                context)
                                            .getInstances()
                                        : null,
                                    miId: inst.id),
                              );
                            },
                            onLongPress: () {
                              deleteInst(context, inst);
                            },
                            leading:
                                CircleAvatar(child: Text(inst.currencySymbol)),
                            title: Text(inst.name),
                            subtitle: Text(inst.currency),
                          );
                        },
                        itemCount: filteredInstances.length,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView lgView(List<DataColumn> columns, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns,
        rows: filteredInstances
            .map(
              (InstanceModel i) => DataRow(cells: [
                DataCell(
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () => {
                            context.router.push(MiEditRoute(
                                updated: (u) => u
                                    ? BlocProvider.of<InstanceCubit>(context)
                                        .getInstances()
                                    : null,
                                miId: i.id))
                          },
                          icon: const Icon(Icons.edit_rounded),
                          color: Colors.amber,
                        ),
                      ),
                      IconButton(
                        onPressed: () => deleteInst(context, i),
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                DataCell(Text(i.name)),
                DataCell(Text(i.currency)),
                DataCell(Text(i.currencySymbol)),
                DataCell(Text(i.currencyCode)),
              ]),
            )
            .toList(),
      ),
    );
  }

  Future<void> deleteInst(BuildContext context, InstanceModel inst) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog.adaptive(
        title: const Text(
          "Delete instance?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text("${inst.name} (${inst.currency})"),
        actions: [
          TextButton(
              onPressed: () async {
                await MasterRepo().deleteInstance(inst.id).then((_) {
                  BlocProvider.of<InstanceCubit>(context).getInstances();
                  Toast.show("Instance Deleted!", duration: 2);
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
}
