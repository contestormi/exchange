class SymbolsState {
  final List<String> symbols;
  final String firstSelectedSymbol;
  final String secondSelectedSymbol;
  final bool isLoading;
  final String firstCurrency;
  final String secondCurrency;

  SymbolsState({
    this.isLoading = false,
    this.symbols = const [],
    this.firstSelectedSymbol = '',
    this.secondSelectedSymbol = '',
    this.firstCurrency = '0',
    this.secondCurrency = '0',
  });

  SymbolsState copyWith({
    bool? isLoading,
    List<String>? symbols,
    String? firstSelectedSymbol,
    String? secondSelectedSymbol,
    String? firstCurrency,
    String? secondCurrency,
  }) {
    return SymbolsState(
      isLoading: isLoading ?? this.isLoading,
      symbols: symbols ?? this.symbols,
      firstSelectedSymbol: firstSelectedSymbol ?? this.firstSelectedSymbol,
      secondSelectedSymbol: secondSelectedSymbol ?? this.secondSelectedSymbol,
      firstCurrency: firstCurrency ?? this.firstCurrency,
      secondCurrency: secondCurrency ?? this.secondCurrency,
    );
  }
}
