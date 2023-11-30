import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/item_model.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit() : super(ItemInitial());
  Future<void> getItems() async {
    emit(ItemLoading());
    await MasterRepo()
        .getItems()
        .then((items) => emit(ItemLoaded(items: items)))
        .catchError((m) {
      emit(ItemError(msg: m.toString()));
    });
  }

  Future<void> viewItem(int itemId) async {
    emit(ItemLoading());
    await MasterRepo()
        .viewItem(itemId)
        .then((item) => emit(ItemSingle(item: item)))
        .catchError((msg) {
      emit(ItemError(msg: msg.toString()));
    });
  }
}
