import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furt/services/product/product_cubit.dart';
import 'package:furt/views/home/ProductItemView.dart';
import '../services/product/product_state.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({
    Key? key,
  }) : super(key: key);

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  late TextEditingController _searchController;
  List<ProductItemView> products = List.empty();

  @override
  void initState() {
    context.read<ProductCubit>().fetchProductsFromFavourite();
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<ProductCubit, ProductState>(listener: (context, state) {
      if (state is ProductStateFetching) {
        products = state.products
            .map((e) => ProductItemView(product: e, exist: true))
            .toList();
      } else if (state is ProductStateExistInShopCart) {
        if (!state.exist) {
          products.removeWhere(
              (element) => element.product.productId == state.productId);
        }
      }
    }, builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'My Favourite',
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            elevation: 0.0,
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        cursorColor: const Color.fromRGBO(205, 24, 79, 1.0),
                        style: const TextStyle(fontSize: 13.0),
                        decoration: InputDecoration(
                          hintText: 'Search Here',
                          hintStyle: const TextStyle(fontSize: 13.0),
                          isDense: false,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.0),
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(205, 24, 79, 1.0),
                                  width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          prefixIcon: const Icon(Icons.search_rounded),
                          prefixIconColor: Colors.black,
                          constraints: BoxConstraints(
                              maxHeight: (height >= 480 && height < 720
                                  ? 40.0
                                  : 60.0)),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list_rounded)),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.5,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemBuilder: (context, index) {
                      return products[index];
                    },
                    itemCount: products.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
