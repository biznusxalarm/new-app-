import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/dummy_product_list_bloc.dart';
import '../../data/models/dummy_product.dart';
import '../../data/repositories/dummy_product_repository.dart';
import '../pages/dummy_product_detail_page.dart';
import '../widgets/dummy_product_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/shop_header.dart';

class DummyProductListPage extends StatelessWidget {
  const DummyProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DummyProductListBloc(
        context.read<DummyProductRepository>(),
      )..add(const DummyProductListStarted()),
      child: const DummyProductListView(),
    );
  }
}

class DummyProductListView extends StatefulWidget {
  const DummyProductListView({super.key});

  @override
  State<DummyProductListView> createState() => _DummyProductListViewState();
}

class _DummyProductListViewState extends State<DummyProductListView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _searchController.addListener(_handleSearchChange);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    _searchController
      ..removeListener(_handleSearchChange)
      ..dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.extentAfter < 320) {
      context
          .read<DummyProductListBloc>()
          .add(const DummyProductListLoadMore());
    }
  }

  void _handleSearchChange() {
    context.read<DummyProductListBloc>().add(
          DummyProductListSearchChanged(_searchController.text),
        );
  }

  void _openDetails(DummyProduct product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DummyProductDetailPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocListener<DummyProductListBloc, DummyProductListState>(
          listenWhen: (previous, current) =>
              current.errorMessage != null &&
              current.errorMessage != previous.errorMessage,
          listener: (context, state) {
            if (!mounted || state.errorMessage == null) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  behavior: SnackBarBehavior.floating,
                ),
              );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const ShopHeader(
                  userName: 'Arun Kumar',
                  subtitle: 'Explore the latest beauty essentials',
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search products',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Products',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textMuted),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<DummyProductListBloc,
                      DummyProductListState>(
                    builder: (context, state) {
                      if (state.isInitialLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final products = state.visibleProducts;

                      if (products.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.search_off_outlined,
                                size: 48,
                                color: AppColors.textMuted,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No products found',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.textMuted,
                                    ),
                              ),
                            ],
                          ),
                        );
                      }

                      final itemCount = products.length +
                          (state.isLoadMoreInProgress ? 1 : 0);

                      return ListView.separated(
                        controller: _scrollController,
                        itemCount: itemCount,
                        padding: const EdgeInsets.only(bottom: 24),
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          if (index >= products.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final product = products[index];
                          return DummyProductCard(
                            product: product,
                            onPressed: () => _openDetails(product),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
