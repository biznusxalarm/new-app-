import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/env/app_env.dart';
import '../models/dummy_product.dart';

class DummyProductRepository {
  DummyProductRepository({required http.Client client}) : _client = client;

  final http.Client _client;

  static const String _productsPath = '/products';

  Future<DummyProductPage> fetchProducts({
    int limit = 10,
    int skip = 0,
  }) async {
    final uri = Uri.parse(
      '${AppEnv.dummyBaseUrl}$_productsPath?limit=$limit&skip=$skip',
    );
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load products (${response.statusCode})');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return DummyProductPage.fromJson(json);
  }

  Future<DummyProduct> fetchProduct(int id) async {
    final uri = Uri.parse('${AppEnv.dummyBaseUrl}$_productsPath/$id');
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load product (${response.statusCode})');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return DummyProduct.fromJson(json);
  }
}
