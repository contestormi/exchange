import 'package:dio/dio.dart';
import 'package:exchange/data/services_impl/endpoints.dart';
import 'package:exchange/domain/services/remote_client.dart';

class RemoteClientImpl implements RemoteClient {
  final Dio dio;

  RemoteClientImpl(this.dio);

  @override
  Future<Response> getRates() async {
    try {
      return await dio.get(
        Endpoints.rates,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> getSymbols() async {
    try {
      return await dio.get(Endpoints.symbols);
    } catch (e) {
      rethrow;
    }
  }
}
