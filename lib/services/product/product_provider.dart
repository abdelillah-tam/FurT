import 'package:furt/services/product/product.dart';

abstract class ProductProvider{
  Future<List<Product>> getProducts(Category category);

  Future<List<Product>> getProductsInFavourite();

  Future<bool> addToFavourite(String productId);

  Future<bool> checkIfExistInFavourite(String productId);

  Future<bool> deleteFromFavourite(String productId);
}