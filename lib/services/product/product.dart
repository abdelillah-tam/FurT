import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:furt/constants/firestore_constants.dart';

@immutable
class Product {
  final String productTitle;
  final String productCategory;
  final String productDescription;
  final double productPrice;
  final int productQuantity;
  final String productImageUrl;

  const Product({
    required this.productTitle,
    required this.productCategory,
    required this.productDescription,
    required this.productPrice,
    required this.productQuantity,
    required this.productImageUrl,
  });

  Product.fromFirebase(
      QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot)
      : productTitle = queryDocumentSnapshot.data()[productTitleField],
        productCategory = queryDocumentSnapshot.data()[productCategoryField],
        productDescription =
            queryDocumentSnapshot.data()[productDescriptionField],
        productPrice = queryDocumentSnapshot.data()[productPriceField],
        productQuantity = queryDocumentSnapshot.data()[productQuantityField],
        productImageUrl = queryDocumentSnapshot.data()[productImageUrlField];
}

enum Category { tables, chairs, sofas, bed, dressers, lighting }
