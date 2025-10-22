part of 'dummy_product_list_bloc.dart';

abstract class DummyProductListEvent extends Equatable {
  const DummyProductListEvent();

  @override
  List<Object?> get props => [];
}

class DummyProductListStarted extends DummyProductListEvent {
  const DummyProductListStarted();
}

class DummyProductListLoadMore extends DummyProductListEvent {
  const DummyProductListLoadMore();
}

class DummyProductListSearchChanged extends DummyProductListEvent {
  const DummyProductListSearchChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
