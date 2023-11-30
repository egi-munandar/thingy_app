part of 'item_cubit.dart';

@immutable
sealed class ItemState {}

final class ItemInitial extends ItemState {}

final class ItemLoading extends ItemState {}

final class ItemLoaded extends ItemState {
  final List<ItemModel> items;

  ItemLoaded({required this.items});
}

final class ItemError extends ItemState {
  final String msg;

  ItemError({required this.msg});
}

final class ItemSingle extends ItemState {
  final ItemModel item;

  ItemSingle({required this.item});
}
