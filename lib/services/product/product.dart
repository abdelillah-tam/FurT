import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:furt/constants/firestore_constants.dart';

@immutable
class Product {
  final String productId;
  final String productTitle;
  final String productCategory;
  final String productDescription;
  final double productPrice;
  final int productQuantity;
  final String productImageUrl;

  const Product({
    required this.productId,
    required this.productTitle,
    required this.productCategory,
    required this.productDescription,
    required this.productPrice,
    required this.productQuantity,
    required this.productImageUrl,
  });

  Product.fromFirebaseQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot)
      : productId = queryDocumentSnapshot.data()[productIdField],
        productTitle = queryDocumentSnapshot.data()[productTitleField],
        productCategory = queryDocumentSnapshot.data()[productCategoryField],
        productDescription =
            queryDocumentSnapshot.data()[productDescriptionField],
        productPrice = queryDocumentSnapshot.data()[productPriceField],
        productQuantity = queryDocumentSnapshot.data()[productQuantityField],
        productImageUrl = queryDocumentSnapshot.data()[productImageUrlField];

  Product.fromFirebaseDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot)
      : productId = documentSnapshot.data()?[productIdField],
        productTitle = documentSnapshot.data()?[productTitleField],
        productCategory = documentSnapshot.data()?[productCategoryField],
        productDescription = documentSnapshot.data()?[productDescriptionField],
        productPrice = documentSnapshot.data()?[productPriceField],
        productQuantity = documentSnapshot.data()?[productQuantityField],
        productImageUrl = documentSnapshot.data()?[productImageUrlField];
}

enum Category { tables, chairs, sofas, bed, dressers, lighting }
