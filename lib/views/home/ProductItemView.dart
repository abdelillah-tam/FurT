import 'package:flutter/material.dart';

class ProductItemView extends StatelessWidget {
  final String productTitle;

  const ProductItemView({Key? key, required this.productTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Wrap(
        children: [
          Column(
            children: [
              Container(
                height: 60.0,
                width: 60.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/bed.jpg'), fit: BoxFit.fill),
                ),
              ),
              Text(productTitle, style: const TextStyle(fontSize: 13.0),),
            ],
          ),
        ],
      ),
    );
  }
}
