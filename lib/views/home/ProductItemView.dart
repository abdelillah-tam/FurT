import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furt/services/product/product_cubit.dart';

import '../../services/product/product.dart';

class ProductItemView extends StatefulWidget {
  final Product product;
  bool exist;

  ProductItemView({Key? key, required this.product, required this.exist})
      : super(key: key);

  @override
  State<ProductItemView> createState() => _ProductItemViewState();
}

class _ProductItemViewState extends State<ProductItemView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            side: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  widget.exist
                      ? context
                          .read<ProductCubit>()
                          .deleteFromFavourite(widget.product.productId)
                      : context
                          .read<ProductCubit>()
                          .addToFavourite(widget.product.productId);
                },
                icon: Icon(
                  widget.exist
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  color: const Color.fromRGBO(205, 24, 79, 1.0),
                ),
                splashColor: Colors.transparent,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: SizedBox(
                      child: Image(
                          image: NetworkImage(widget.product.productImageUrl),
                          fit: BoxFit.fill)),
                ),
                Center(
                  child: Text(
                    widget.product.productTitle,
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${widget.product.productPrice}",
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(205, 24, 79, 1.0),
                      ),
                    ),
                    CircleAvatar(
                      radius: (height >= 480 && height < 720 ? 8.0 : 12.0),
                      backgroundColor: const Color.fromRGBO(205, 24, 79, 1.0),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        onPressed: () {},
                        icon: Icon(
                          Icons.shopping_cart_rounded,
                          size: (height >= 480 && height < 720 ? 8.0 : 12.0),
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
