import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../core/theme/app_theme.dart';
import '../features/dummy_products/data/repositories/dummy_product_repository.dart';
import '../features/dummy_products/presentation/pages/dummy_product_list_page.dart';
import '../features/fake_store/data/repositories/fake_store_repository.dart';
import '../features/fake_store/presentation/pages/fake_store_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final http.Client _httpClient = http.Client();
  late final DummyProductRepository _dummyRepository;
  late final FakeStoreRepository _fakeStoreRepository;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _dummyRepository = DummyProductRepository(client: _httpClient);
    _fakeStoreRepository = FakeStoreRepository(client: _httpClient);
  }

  @override
  void dispose() {
    _httpClient.close();
    super.dispose();
  }

  void _onNavTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DummyProductRepository>.value(value: _dummyRepository),
        RepositoryProvider<FakeStoreRepository>.value(value: _fakeStoreRepository),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            DummyProductListPage(),
            FakeStoreListPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onNavTapped,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              activeIcon: Icon(Icons.storefront),
              label: 'Dummy Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Fake Store',
            ),
          ],
        ),
      ),
    );
  }
}
