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

class ProductStateExistInShopCart extends ProductState {
  final bool exist;
  final String productId;

  const ProductStateExistInShopCart(
      {required this.exist, required this.productId,required bool isFetching})
      : super(isFetchingProducts: false);
}

