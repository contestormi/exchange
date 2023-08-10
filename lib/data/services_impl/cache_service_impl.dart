import 'package:exchange/domain/services/cache_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheServiceImpl implements CacheService {
  final SharedPreferences prefs;

  CacheServiceImpl(this.prefs);

  @override
  String getStringFromCache(String key) {
    return prefs.getString(key) ?? '';
  }

  @override
  List<String> getListFromCache(String key) {
    return prefs.getStringList(key) ?? [];
  }

  @override
  Future<void> saveStringToCache(String key, String value) async {
    await prefs.setString(key, value);
  }

  @override
  Future<void> saveListToCache(String key, List<String> value) async {
    await prefs.setStringList(key, value);
  }
}
