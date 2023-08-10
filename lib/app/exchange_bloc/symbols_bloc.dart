import 'package:exchange/app/exchange_bloc/symbols_event.dart';
import 'package:exchange/app/exchange_bloc/symbols_state.dart';
import 'package:exchange/data/models/enums.dart';
import 'package:exchange/domain/repository/exchange_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SymbolsBloc extends Bloc<SymbolsEvent, SymbolsState> {
  final ExchangeRepository _exchangeRepository;

  SymbolsBloc(this._exchangeRepository) : super(SymbolsState()) {
    on<SymbolsLoadEvent>(_getSymbols);
    on<ChangeSymbolsEvent>(_changeSymbol);
    on<GetExchangeEvent>(_getExchange);
  }

  Future<void> _getSymbols(
      SymbolsEvent event, Emitter<SymbolsState> emit) async {
    final symbols = await _exchangeRepository.getSymbols();
    emit(
      state.copyWith(
        isLoading: false,
        symbols: symbols,
        firstSelectedSymbol: symbols.first,
        secondSelectedSymbol: symbols.last,
      ),
    );
  }

  Future<void> _changeSymbol(
      ChangeSymbolsEvent event, Emitter<SymbolsState> emit) async {
    if (event.symbol == ChangedSymbol.first) {
      emit(state.copyWith(firstSelectedSymbol: event.selectedSymbol));
    } else {
      emit(state.copyWith(secondSelectedSymbol: event.selectedSymbol));
    }
  }

  Future<void> _getExchange(
      GetExchangeEvent event, Emitter<SymbolsState> emit) async {
    final currency = await _exchangeRepository.getRates();

    final firstCurrency = double.tryParse(event.currency) ?? 0.0;

    emit(
      state.copyWith(
        firstCurrency: event.currency,
        secondCurrency:
            (firstCurrency * currency[state.firstSelectedSymbol]).toString(),
      ),
    );
  }
}
