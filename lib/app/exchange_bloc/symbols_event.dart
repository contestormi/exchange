import 'package:exchange/data/models/enums.dart';

abstract class SymbolsEvent {}

class SymbolsLoadEvent extends SymbolsEvent {}

class ChangeSymbolsEvent extends SymbolsEvent {
  final ChangedSymbol symbol;
  final String selectedSymbol;

  ChangeSymbolsEvent(this.symbol, this.selectedSymbol);
}

class GetExchangeEvent extends SymbolsEvent {
  final String currency;

  GetExchangeEvent(
    this.currency,
  );
}
