import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/dummy_product.dart';
import '../data/repositories/dummy_product_repository.dart';

part 'dummy_product_list_event.dart';
part 'dummy_product_list_state.dart';

class DummyProductListBloc
    extends Bloc<DummyProductListEvent, DummyProductListState> {
  DummyProductListBloc(this._repository)
      : super(const DummyProductListState()) {
    on<DummyProductListStarted>(_onStarted);
    on<DummyProductListLoadMore>(_onLoadMore);
    on<DummyProductListSearchChanged>(_onSearchChanged);
  }

  final DummyProductRepository _repository;
  static const int _pageSize = 10;

  Future<void> _onStarted(
    DummyProductListStarted event,
    Emitter<DummyProductListState> emit,
  ) async {
    if (state.isInitialLoading) return;
    emit(state.copyWith(
      isInitialLoading: true,
      errorMessage: null,
      hasReachedEnd: false,
      products: [],
    ));

    try {
      final page =
          await _repository.fetchProducts(limit: _pageSize, skip: 0);
      final products = page.products;
      emit(state.copyWith(
        products: products,
        isInitialLoading: false,
        hasReachedEnd: products.length >= page.total,
      ));
    } catch (error) {
      emit(state.copyWith(
        isInitialLoading: false,
        errorMessage: 'Unable to load products. Please try again.',
      ));
    }
  }

  Future<void> _onLoadMore(
    DummyProductListLoadMore event,
    Emitter<DummyProductListState> emit,
  ) async {
    if (state.isInitialLoading ||
        state.isLoadMoreInProgress ||
        state.hasReachedEnd) {
      return;
    }

    emit(state.copyWith(
      isLoadMoreInProgress: true,
      errorMessage: null,
    ));

    try {
      final page = await _repository.fetchProducts(
        limit: _pageSize,
        skip: state.products.length,
      );

      final newProducts = List<DummyProduct>.from(state.products)
        ..addAll(page.products);

      emit(state.copyWith(
        products: newProducts,
        isLoadMoreInProgress: false,
        hasReachedEnd: newProducts.length >= page.total ||
            page.products.isEmpty,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoadMoreInProgress: false,
        errorMessage: 'Failed to load more products. Please retry.',
      ));
    }
  }

  void _onSearchChanged(
    DummyProductListSearchChanged event,
    Emitter<DummyProductListState> emit,
  ) {
    emit(state.copyWith(searchTerm: event.query));
  }
}
