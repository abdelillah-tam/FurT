import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furt/services/product/product.dart';
import 'package:furt/services/product/product_cubit.dart';
import 'package:furt/services/product/product_state.dart';

class DetailsView extends StatefulWidget {
  // final Product product;
  const DetailsView({Key? key}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late bool checked;

  @override
  void initState() {
    checked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Product;
    return BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  elevation: 0.0,
                  title: const Text(
                    'Details',
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.keyboard_backspace_rounded,
                      color: Colors.black,
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                        )),
                  ],
                ),
                backgroundColor: Colors.white,
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                              args.productTitle,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checked = !checked;
                                });
                              },
                              child: Icon(
                                checked
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline_rounded,
                                color: const Color.fromRGBO(205, 24, 79, 1.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: SizedBox(
                          height: 200.0,
                          child: Image(
                            image: NetworkImage(args.productImageUrl),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(args.productDescription),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          children: [
                            const Text(
                              'Price: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('\$${args.productPrice}')
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        SizedBox(
                          width: 35.0,
                          child: MaterialButton(
                            onPressed: () {},
                            padding: const EdgeInsets.only(left: 20.0),
                            color: const Color.fromRGBO(205, 24, 79, 1.0),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(90.0),
                              ),
                            ),
                            elevation: 0.0,
                            child: const Text(
                              '-',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 45.0,
                          child: TextButton(
                            onPressed: null,
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(205, 24, 79, 1.0),
                              shape: RoundedRectangleBorder(),
                              elevation: 0.0,
                            ),
                            child: Text(
                              '300',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 35.0,
                          child: MaterialButton(
                            onPressed: () {},
                            padding: const EdgeInsets.only(right: 20.0),
                            color: const Color.fromRGBO(205, 24, 79, 1.0),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(90.0)),
                            ),
                            elevation: 0.0,
                            child: const Text(
                              '+',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(
                        width: 190.0,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: const EdgeInsets.symmetric(horizontal: 48.0),
                          color: const Color.fromRGBO(205, 24, 79, 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          elevation: 0.0,
                          child: const Text(
                            'Add To Cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
