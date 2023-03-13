import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furt/services/product/product_cubit.dart';
import 'package:furt/views/cart_item_view.dart';

import '../services/product/product_state.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<CartItemView> products = List.empty();

  @override
  void initState() {
    context.read<ProductCubit>().getProductsExistInShopCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if(state is ProductStateFetching){
            products = state.products.map((e) => CartItemView(product: e, exist: true)).toList();
          }else if(state is ProductStateAddedToShopcart){
            if(!state.added){
              products.removeWhere((element) => element.product.productId == state.productId);
            }else if(state.added && state.updatedProduct != null){
              final oldProduct = products.firstWhere((element) => element.product.productId == state.updatedProduct!.productId);
              final newProduct = CartItemView(product: state.updatedProduct!, exist: oldProduct.exist);
              final indexOfOldProduct = products.indexOf(oldProduct);
              products.removeAt(indexOfOldProduct);
              products.insert(indexOfOldProduct, newProduct);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Cart',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            backgroundColor: Colors.white,
            body: ListView.builder(
              itemBuilder: (context, index) {
                return products[index];
              },
              itemCount: products.length,
            ),
          );
        });
  }
}
