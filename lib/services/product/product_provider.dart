import 'package:furt/services/product/product.dart';

abstract class ProductProvider{
  Future<List<Product>> getProducts(Category category);


}