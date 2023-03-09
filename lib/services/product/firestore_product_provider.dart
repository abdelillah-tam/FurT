import 'package:furt/services/auth/firebase_auth_provider.dart';
import 'package:furt/services/product/product.dart';
import 'package:furt/services/product/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furt/constants/firestore_constants.dart';

class FirestoreProductProvider implements ProductProvider {
  @override
  Future<List<Product>> getProducts(Category category) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where(productCategoryField, isEqualTo: category.name)
        .get();

    final listOfProducts =
        querySnapshot.docs.map((e) => Product.fromFirebase(e)).toList();
    return listOfProducts;
  }

  @override
  Future<List<Product>> getProductsInFavourite() async {
    final idQuerySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthProvider().currentUser!.email)
        .collection('favourite')
        .get();
    final productsId = idQuerySnapshot.docs.map((e) => e.data()[productIdField]).toList();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where(productIdField, whereIn: productsId)
        .get();

    final listOfProducts =
        querySnapshot.docs.map((e) => Product.fromFirebase(e)).toList();
    return listOfProducts;
  }

  @override
  Future<bool> addToFavourite(String productId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthProvider().currentUser!.email)
        .collection('favourite')
        .doc(productId)
        .set({
      productIdField: productId,
    });

    final result = await checkIfExistInFavourite(productId);

    return result;
  }

  @override
  Future<bool> checkIfExistInFavourite(String productId) async {
    final querySnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthProvider().currentUser!.email)
        .collection('favourite')
        .where(productIdField, isEqualTo: productId)
        .get();

    if (querySnap.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<bool> deleteFromFavourite(String productId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthProvider().currentUser!.email)
        .collection('favourite')
        .doc(productId)
        .delete();

    final result = await checkIfExistInFavourite(productId);
    return result;
  }
}
