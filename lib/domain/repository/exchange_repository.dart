abstract class ExchangeRepository {
  Future<List<String>> getSymbols();

  Future<Map<String, dynamic>> getRates();
}
