part of 'fake_store_product_bloc.dart';

class FakeStoreProductState extends Equatable {
  const FakeStoreProductState({
    this.products = const <FakeStoreProduct>[],
    this.isLoading = false,
    this.errorMessage,
    this.searchTerm = '',
  });

  final List<FakeStoreProduct> products;
  final bool isLoading;
  final String? errorMessage;
  final String searchTerm;

  List<FakeStoreProduct> get visibleProducts {
    if (searchTerm.trim().isEmpty) {
      return products;
    }
    final query = searchTerm.trim().toLowerCase();
    return products
        .where(
          (product) =>
              product.title.toLowerCase().contains(query) ||
              product.category.toLowerCase().contains(query),
        )
        .toList();
  }

  FakeStoreProductState copyWith({
    List<FakeStoreProduct>? products,
    bool? isLoading,
    String? errorMessage,
    String? searchTerm,
  }) {
    return FakeStoreProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, errorMessage, searchTerm];
}
