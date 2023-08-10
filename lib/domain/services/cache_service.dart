abstract class CacheService {
  Future<void> saveStringToCache(String key, String value);

  Future<void> saveListToCache(String key, List<String> value);

  String getStringFromCache(String key);

  List<String> getListFromCache(String key);
}
