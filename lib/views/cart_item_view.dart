import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furt/services/product/product_cubit.dart';

import '../../services/product/product.dart';

class CartItemView extends StatefulWidget {
  final Product product;
  bool exist;

  CartItemView({Key? key, required this.product, required this.exist})
      : super(key: key);

  @override
  State<CartItemView> createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
  String? value;

  @override
  void initState() {
    value = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        alignment: Alignment.topLeft,
        height: 160,
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              side: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  width: 70,
                  height: 120,
                  child: Image(
                      image: NetworkImage(widget.product.productImageUrl),
                      fit: BoxFit.fitWidth),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              widget.product.productTitle,
                              style: const TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                context
                                    .read<ProductCubit>()
                                    .deleteFromShopCart(widget.product);
                              },
                              icon: Icon(
                                Icons.cancel_outlined,
                                size: (height >= 480 && height < 720
                                    ? 16.0
                                    : 24.0),
                                color: const Color.fromRGBO(205, 24, 79, 1.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        widget.product.productDescription,
                        style:
                            const TextStyle(fontSize: 10.0, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                '\$${widget.product.productPrice}',
                                style: const TextStyle(
                                  color: Color.fromRGBO(205, 24, 79, 1.0),
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              child: TextButton(
                                onPressed: () {
                                  context.read<ProductCubit>().decreaseQuantity(widget.product);
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(205, 24, 79, 1.0),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(360)),
                                    ),
                                    padding: EdgeInsets.zero),
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${widget.product.productQuantity}',
                              ),
                            ),
                            Flexible(
                              child: TextButton(
                                onPressed: () {
                                  context.read<ProductCubit>().increaseQuantity(widget.product);
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(205, 24, 79, 1.0),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(360)),
                                    ),
                                    padding: EdgeInsets.zero),
                                child: const Text(
                                  '+',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                ),
                              ),
                            ),

                          ],

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
