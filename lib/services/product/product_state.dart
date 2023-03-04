import 'package:flutter/foundation.dart';
import 'package:furt/services/product/product.dart';

@immutable
abstract class ProductState {
  final bool isFetchingProducts;
  final String? fetchingText;

  const ProductState({
    required this.isFetchingProducts,
    this.fetchingText = 'Wait ..',
  });
}

class ProductStateFetching extends ProductState {
  final List<Product> products;

  const ProductStateFetching(
    this.products, {
    required bool isFetching,
    String? fetchingText,
  }) : super(isFetchingProducts: isFetching, fetchingText: fetchingText);
}
