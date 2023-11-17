import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/currency_model.dart';

part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit() : super(CurrencyInitial());
  Future<void> getCurrencies() async {
    emit(CurrencyLoading());
    final List<CurrencyModel> curs =
        await MasterRepo().getCurrencies().catchError((er) {
      emit(CurrencyError(msg: er.toString()));
    });
    emit(CurrencyLoaded(currencies: curs));
  }

  Future<void> viewCurrency(int currencyId) async {
    emit(CurrencyLoading());
    final CurrencyModel cur =
        await MasterRepo().viewCurrency(currencyId).catchError((er) {
      emit(CurrencyError(msg: er.toString()));
    });
    emit(CurrencySingle(currency: cur));
  }
}
