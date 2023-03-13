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

    final listOfProducts = querySnapshot.docs
        .map((e) => Product.fromFirebaseQueryDocumentSnapshot(e))
        .toList();
    return listOfProducts;
  }

  @override
  Future<List<Product>> getProductsInFavourite() async {
    final idQuerySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthProvider().currentUser!.email)
        .collection('favourite')
        .get();
    final productsId =
        idQuerySnapshot.docs.map((e) => e.data()[productIdField]).toList();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where(productIdField, whereIn: productsId)
        .get();

    final listOfProducts = querySnapshot.docs
        .map((e) => Product.fromFirebaseQueryDocumentSnapshot(e))
        .toList();
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

  @override
  Future<Product?> addToShopCart(Product product, int quantity) async {
    final newQuantity = product.productQuantity - quantity;
    if (newQuantity >= 0) {
      if (!await checkIfExistInShopCart(product.productId)) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuthProvider().currentUser!.email)
            .collection('shopcart')
            .doc(product.productId)
            .set({
          productIdField: product.productId,
          productQuantityField: quantity,
          productCategoryField: product.productCategory,
          productDescriptionField: product.productDescription,
          productImageUrlField: product.productImageUrl,
          productPriceField: product.productPrice,
          productTitleField: product.productTitle,
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuthProvider().currentUser!.email)
            .collection('shopcart')
            .doc(product.productId)
            .update({productQuantityField: FieldValue.increment(quantity)});
      }
      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.productId)
          .update({
        productQuantityField: FieldValue.increment(-quantity),
      });

      final result = await checkIfExistInShopCart(product.productId);
      if (result) {
        final updatedProduct = await FirebaseFirestore.instance
            .collection('products')
            .doc(product.productId)
            .get();

        return Product.fromFirebaseDocumentSnapshot(updatedProduct);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> checkIfExistInShopCart(String productId) async {
    final querySnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthProvider().currentUser!.email)
        .collection('shopcart')
        .where(productIdField, isEqualTo: productId)
        .get();

    if (querySnap.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<List<Product>> getProductsExistInShopCart() async {
    final querySnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthProvider().currentUser!.email)
        .collection('shopcart')
        .get();

    final listOfProducts = querySnap.docs
        .map((e) => Product.fromFirebaseQueryDocumentSnapshot(e))
        .toList();
    return listOfProducts;
  }

  @override
  Future<bool> deleteFromShopCart(Product product) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuthProvider().currentUser!.email)
        .collection('shopcart')
        .doc(product.productId)
        .delete();

    await FirebaseFirestore.instance
        .collection('products')
        .doc(product.productId)
        .update(
      {productQuantityField: FieldValue.increment(product.productQuantity)},
    );

    final result = await checkIfExistInShopCart(product.productId);

    return result;
  }

  @override
  Future<Product?> decreaseQuantity(Product product) async {
    if(product.productQuantity - 1 >= 0){
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuthProvider().currentUser!.email)
          .collection('shopcart')
          .doc(product.productId)
          .update({productQuantityField: FieldValue.increment(-1)});

      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.productId)
          .update({
        productQuantityField: FieldValue.increment(1),
      });

      final updatedProduct = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuthProvider().currentUser!.email)
          .collection('shopcart')
          .doc(product.productId)
          .get();

      return Product.fromFirebaseDocumentSnapshot(updatedProduct);
    }
    return null;
  }

  @override
  Future<Product?> increaseQuantity(Product product) async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc(product.productId)
        .get();

    final productInStore = Product.fromFirebaseDocumentSnapshot(documentSnapshot);

    if(productInStore.productQuantity - 1 >= 0){
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuthProvider().currentUser!.email)
          .collection('shopcart')
          .doc(product.productId)
          .update({productQuantityField: FieldValue.increment(1)});

      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.productId)
          .update({
        productQuantityField: FieldValue.increment(-1),
      });

      final updatedProduct = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuthProvider().currentUser!.email)
          .collection('shopcart')
          .doc(product.productId)
          .get();

      return Product.fromFirebaseDocumentSnapshot(updatedProduct);
    }

    return null;
  }
}
