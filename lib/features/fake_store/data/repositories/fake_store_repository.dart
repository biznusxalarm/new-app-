import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/env/app_env.dart';
import '../models/fake_store_product.dart';

class FakeStoreRepository {
  FakeStoreRepository({required http.Client client}) : _client = client;

  final http.Client _client;
  static const String _productsPath = '/products';

  Future<List<FakeStoreProduct>> fetchProducts() async {
    final uri = Uri.parse('${AppEnv.fakeStoreBaseUrl}$_productsPath');
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load products (${response.statusCode})');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => FakeStoreProduct.fromJson(
              item as Map<String, dynamic>,
            ))
        .toList();
  }
}
