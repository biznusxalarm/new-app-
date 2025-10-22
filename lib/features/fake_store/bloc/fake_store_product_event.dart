part of 'fake_store_product_bloc.dart';

abstract class FakeStoreProductEvent extends Equatable {
  const FakeStoreProductEvent();

  @override
  List<Object?> get props => [];
}

class FakeStoreProductsRequested extends FakeStoreProductEvent {
  const FakeStoreProductsRequested();
}

class FakeStoreSearchChanged extends FakeStoreProductEvent {
  const FakeStoreSearchChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
