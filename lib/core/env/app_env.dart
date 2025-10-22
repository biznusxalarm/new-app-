import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  AppEnv._();

  static String get dummyBaseUrl => _read('DUMMY_BASE_URL');

  static String get fakeStoreBaseUrl => _read('FAKESTORE_BASE_URL');

  static String _read(String key) {
    final value = dotenv.maybeGet(key);
    if (value == null || value.isEmpty) {
      throw StateError('Environment variable $key is missing.');
    }
    return value;
  }
}
