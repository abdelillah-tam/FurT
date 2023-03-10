import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furt/services/product/product.dart';
import 'package:furt/services/product/product_cubit.dart';
import 'package:furt/services/product/product_state.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late bool favourite;
  late DetailsArgument args;
  bool firstRun = true;


  @override
  Widget build(BuildContext context) {
    if(firstRun) {
      args = ModalRoute
          .of(context)!
          .settings
          .arguments as DetailsArgument;
      favourite = args.exist;
      firstRun = false;
    }
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductStateExistInShopCart) {
          setState(() {
            favourite = state.exist;
          });
        }
      },
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
                            args.product.productTitle,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              favourite
                                  ? context
                                      .read<ProductCubit>()
                                      .deleteFromFavourite(
                                          args.product.productId)
                                  : context
                                      .read<ProductCubit>()
                                      .addToFavourite(args.product.productId);
                            },
                            child: Icon(
                              favourite
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
                          image: NetworkImage(args.product.productImageUrl),
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
                      child: Text(args.product.productDescription),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: [
                          const Text(
                            'Price: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('\$${args.product.productPrice}')
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
                            shape: const RoundedRectangleBorder(),
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
      },
    );
  }
}

class DetailsArgument {
  final Product product;
  final bool exist;

  const DetailsArgument({
    required this.product,
    required this.exist,
  });
}
