import 'package:furt/services/product/product.dart';

abstract class ProductProvider {
  Future<List<Product>> getProducts(Category category);

  Future<List<Product>> getProductsInFavourite();

  Future<bool> addToFavourite(String productId);

  Future<bool> checkIfExistInFavourite(String productId);

  Future<bool> deleteFromFavourite(String productId);

  Future<Product?> addToShopCart(Product product, int quantity);

  Future<bool> checkIfExistInShopCart(String productId);

  Future<List<Product>> getProductsExistInShopCart();

  Future<bool> deleteFromShopCart(Product productId);

  Future<Product?> increaseQuantity(Product productId);
  Future<Product?> decreaseQuantity(Product productId);
}
