import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/fake_store_product.dart';
import '../data/repositories/fake_store_repository.dart';

part 'fake_store_product_event.dart';
part 'fake_store_product_state.dart';

class FakeStoreProductBloc
    extends Bloc<FakeStoreProductEvent, FakeStoreProductState> {
  FakeStoreProductBloc(this._repository)
      : super(const FakeStoreProductState()) {
    on<FakeStoreProductsRequested>(_onProductsRequested);
    on<FakeStoreSearchChanged>(_onSearchChanged);
  }

  final FakeStoreRepository _repository;

  Future<void> _onProductsRequested(
    FakeStoreProductsRequested event,
    Emitter<FakeStoreProductState> emit,
  ) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final products = await _repository.fetchProducts();
      emit(state.copyWith(
        isLoading: false,
        products: products,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Unable to load products. Please try again.',
      ));
    }
  }

  void _onSearchChanged(
    FakeStoreSearchChanged event,
    Emitter<FakeStoreProductState> emit,
  ) {
    emit(state.copyWith(searchTerm: event.query));
  }
}
