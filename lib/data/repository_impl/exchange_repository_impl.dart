import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exchange/app/app_constants.dart';
import 'package:exchange/data/dtos/rates_dto.dart';
import 'package:exchange/data/dtos/symbol_dto.dart';
import 'package:exchange/domain/repository/exchange_repository.dart';
import 'package:exchange/domain/services/cache_service.dart';
import 'package:exchange/domain/services/remote_client.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  ExchangeRepositoryImpl(this._remote, this._cache);

  final RemoteClient _remote;

  final CacheService _cache;

  @override
  Future<Map<String, dynamic>> getRates() async {
    try {
      final data = Rates.fromJson((await _remote.getRates()).data);
      final currency = data.rates;
      if (currency != null) {
        String rates = jsonEncode(currency);
        _cache.saveStringToCache(AppConstants.ratesKey, rates);
        return currency;
      } else {
        return {};
      }
    } on DioException catch (_) {
      return jsonDecode(_cache.getStringFromCache(AppConstants.ratesKey));
    }
  }

  @override
  Future<List<String>> getSymbols() async {
    try {
      final data = Symbols.fromJson((await _remote.getSymbols()).data);
      final symbols = data.symbols;
      if (symbols != null) {
        _cache.saveListToCache(AppConstants.symbolsKey, symbols.keys.toList());
        return symbols.keys.toList();
      } else {
        return [];
      }
    } on DioException catch (_) {
      return _cache.getListFromCache(AppConstants.symbolsKey);
    }
  }
}
