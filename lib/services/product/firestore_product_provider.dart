import 'package:furt/services/product/product.dart';
import 'package:furt/services/product/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furt/constants/firestore_constants.dart';

class FirestoreProductProvider implements ProductProvider {
  @override
  Future<List<Product>> getProducts(Category category) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where(productCategoryField, isEqualTo: category.name).get();

    final listOfProducts = querySnapshot.docs.map((e) => Product.fromFirebase(e)).toList();
    return listOfProducts;
  }
}
