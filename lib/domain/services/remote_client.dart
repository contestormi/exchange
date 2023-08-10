import 'package:dio/dio.dart';

abstract class RemoteClient {
  Future<Response> getSymbols();

  Future<Response> getRates();
}
