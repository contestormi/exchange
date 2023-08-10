import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exchange/data/services_impl/cache_service_impl.dart';
import 'package:exchange/data/services_impl/remote_client_impl.dart';
import 'package:exchange/domain/secrets.dart';
import 'package:exchange/domain/services/cache_service.dart';
import 'package:exchange/domain/services/remote_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DataModule {
  const DataModule();

  static Future<DataModule> init() => _DataModule.init();

  T get<T>();
}

class _DataModule extends DataModule {
  const _DataModule({
    required this.remoteClient,
    required this.cache,
  });

  final RemoteClient remoteClient;
  final CacheService cache;

  static Future<DataModule> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final dio = Dio(
      BaseOptions(
        queryParameters: {
          'access_key': Secrets.token,
        },
      ),
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final RemoteClient remoteClient = RemoteClientImpl(dio);
      final CacheService cache = CacheServiceImpl(prefs);

      return _DataModule(
        remoteClient: remoteClient,
        cache: cache,
      );
    } on Object catch (error, _) {
      debugPrint('Data module failed initialize.');
      exit(0);
    }
  }

  @override
  T get<T>() {
    switch (T) {
      case RemoteClient:
        return remoteClient as T;
      case CacheService:
        return cache as T;
      default:
        debugPrint('Error');
        exit(0);
    }
  }
}
