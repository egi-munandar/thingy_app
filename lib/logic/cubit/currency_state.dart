part of 'currency_cubit.dart';

@immutable
sealed class CurrencyState {}

final class CurrencyInitial extends CurrencyState {}

final class CurrencyLoading extends CurrencyState {}

final class CurrencyLoaded extends CurrencyState {
  final List<CurrencyModel> currencies;

  CurrencyLoaded({required this.currencies});
}

final class CurrencySingle extends CurrencyState {
  final CurrencyModel currency;

  CurrencySingle({required this.currency});
}

final class CurrencyError extends CurrencyState {
  final String msg;

  CurrencyError({required this.msg});
}
