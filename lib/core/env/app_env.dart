import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  AppEnv._();

  static final Map<String, String> _defaults = <String, String>{
    'DUMMY_BASE_URL': 'https://dummyjson.com',
    'FAKESTORE_BASE_URL': 'https://fakestoreapi.com',
  };

  static String get dummyBaseUrl => _read('DUMMY_BASE_URL');

  static String get fakeStoreBaseUrl => _read('FAKESTORE_BASE_URL');

  static String _read(String key) {
    final value = dotenv.maybeGet(key);
    if (value != null && value.isNotEmpty) {
      return value;
    }

    final fallback = _defaults[key];
    if (fallback != null) {
      return fallback;
    }

    throw StateError('Environment variable $key is missing.');
  }
}
