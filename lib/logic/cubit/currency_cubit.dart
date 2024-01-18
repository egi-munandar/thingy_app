import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/currency_model.dart';

part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit() : super(CurrencyInitial());
  Future<void> getCurrencies() async {
    emit(CurrencyLoading());
    await MasterRepo().getCurrencies().then((v) {
      emit(CurrencyLoaded(currencies: v));
    }).catchError((er) {
      emit(CurrencyError(msg: er.toString()));
    });
  }

  Future<void> viewCurrency(int currencyId) async {
    emit(CurrencyLoading());
    final CurrencyModel cur =
        await MasterRepo().viewCurrency(currencyId).catchError((er) {
      emit(CurrencyError(msg: er.toString()));
      return er;
    });
    emit(CurrencySingle(currency: cur));
  }
}
