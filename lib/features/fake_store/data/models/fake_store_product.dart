import 'package:equatable/equatable.dart';

class FakeStoreProduct extends Equatable {
  const FakeStoreProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final FakeStoreRating rating;

  factory FakeStoreProduct.fromJson(Map<String, dynamic> json) {
    return FakeStoreProduct(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      image: json['image'] as String? ?? '',
      rating: FakeStoreRating.fromJson(
        json['rating'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
      ];
}

class FakeStoreRating extends Equatable {
  const FakeStoreRating({
    required this.rate,
    required this.count,
  });

  final double rate;
  final int count;

  factory FakeStoreRating.fromJson(Map<String, dynamic> json) {
    return FakeStoreRating(
      rate: (json['rate'] as num?)?.toDouble() ?? 0,
      count: json['count'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [rate, count];
}
