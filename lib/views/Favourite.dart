import 'package:flutter/material.dart';


class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key,}) : super(key: key);


  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Favourite',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
