import 'package:equatable/equatable.dart';

class DummyProductPage extends Equatable {
  const DummyProductPage({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<DummyProduct> products;
  final int total;
  final int skip;
  final int limit;

  factory DummyProductPage.fromJson(Map<String, dynamic> json) {
    return DummyProductPage(
      products: (json['products'] as List<dynamic>? ?? [])
          .map((item) => DummyProduct.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int? ?? 0,
      skip: json['skip'] as int? ?? 0,
      limit: json['limit'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [products, total, skip, limit];
}

class DummyProduct extends Equatable {
  const DummyProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.images,
    required this.thumbnail,
    required this.reviews,
    required this.brand,
  });

  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String warrantyInformation;
  final String shippingInformation;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final List<String> images;
  final String thumbnail;
  final List<ProductReview> reviews;
  final String brand;

  double get discountedPrice => price;

  double get originalPrice {
    if (discountPercentage <= 0) {
      return price;
    }
    final discountedFraction = 1 - (discountPercentage / 100);
    if (discountedFraction <= 0) {
      return price;
    }
    return price / discountedFraction;
  }

  factory DummyProduct.fromJson(Map<String, dynamic> json) {
    return DummyProduct(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      stock: json['stock'] as int? ?? 0,
      warrantyInformation: json['warrantyInformation'] as String? ?? 'No warranty info',
      shippingInformation: json['shippingInformation'] as String? ?? 'Shipping details not available',
      returnPolicy: json['returnPolicy'] as String? ?? 'No return policy shared',
      minimumOrderQuantity: json['minimumOrderQuantity'] as int? ?? 1,
      images: (json['images'] as List<dynamic>? ?? [])
          .map((item) => item as String)
          .toList(),
      thumbnail: json['thumbnail'] as String? ?? '',
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((item) => ProductReview.fromJson(item as Map<String, dynamic>))
          .toList(),
      brand: json['brand'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        price,
        discountPercentage,
        rating,
        stock,
        warrantyInformation,
        shippingInformation,
        returnPolicy,
        minimumOrderQuantity,
        images,
        thumbnail,
        reviews,
        brand,
      ];
}

class ProductReview extends Equatable {
  const ProductReview({
    required this.rating,
    required this.comment,
    required this.reviewerName,
  });

  final double rating;
  final String comment;
  final String reviewerName;

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      comment: json['comment'] as String? ?? '',
      reviewerName: json['reviewerName'] as String? ?? 'Anonymous',
    );
  }

  @override
  List<Object?> get props => [rating, comment, reviewerName];
}
