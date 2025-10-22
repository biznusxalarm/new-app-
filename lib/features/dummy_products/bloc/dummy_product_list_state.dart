part of 'dummy_product_list_bloc.dart';

class DummyProductListState extends Equatable {
  const DummyProductListState({
    this.products = const <DummyProduct>[],
    this.isInitialLoading = false,
    this.isLoadMoreInProgress = false,
    this.hasReachedEnd = false,
    this.errorMessage,
    this.searchTerm = '',
  });

  final List<DummyProduct> products;
  final bool isInitialLoading;
  final bool isLoadMoreInProgress;
  final bool hasReachedEnd;
  final String? errorMessage;
  final String searchTerm;

  List<DummyProduct> get visibleProducts {
    if (searchTerm.trim().isEmpty) {
      return products;
    }

    final query = searchTerm.trim().toLowerCase();
    return products
        .where(
          (product) =>
              product.title.toLowerCase().contains(query) ||
              product.category.toLowerCase().contains(query) ||
              product.brand.toLowerCase().contains(query),
        )
        .toList();
  }

  DummyProductListState copyWith({
    List<DummyProduct>? products,
    bool? isInitialLoading,
    bool? isLoadMoreInProgress,
    bool? hasReachedEnd,
    String? errorMessage,
    String? searchTerm,
  }) {
    return DummyProductListState(
      products: products ?? this.products,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadMoreInProgress:
          isLoadMoreInProgress ?? this.isLoadMoreInProgress,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      errorMessage: errorMessage,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object?> get props => [
        products,
        isInitialLoading,
        isLoadMoreInProgress,
        hasReachedEnd,
        errorMessage,
        searchTerm,
      ];
}
