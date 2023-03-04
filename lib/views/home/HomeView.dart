import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furt/services/product/product_cubit.dart';
import 'package:furt/services/product/product_state.dart';
import 'package:furt/views/AccountView.dart';
import 'package:furt/views/CartView.dart';
import 'package:furt/services/product/product.dart';
import 'package:furt/views/Favourite.dart';
import 'package:furt/views/home/CategoryItemView.dart';
import 'package:furt/views/home/Destination.dart';
import 'package:furt/views/home/ProductItemView.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  static const List<Widget> allWidgets = [
    HomeView(),
    CartView(),
    FavouriteView(),
    AccountView()
  ];

  static const List<Destination> allDestinations = [
    Destination(index: 0, label: 'Home', iconData: Icons.home),
    Destination(index: 1, label: 'My Cart', iconData: Icons.shopping_cart),
    Destination(index: 2, label: 'My Favourite', iconData: Icons.favorite),
    Destination(index: 3, label: 'Account', iconData: Icons.account_circle),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: allWidgets[selectedIndex],
        bottomNavigationBar: Container(
          height: 50.0,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  topRight: Radius.circular(6.0)),
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 10),
              ]),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              selectedItemColor: const Color.fromRGBO(205, 24, 79, 1.0),
              unselectedItemColor: Colors.black,
              showSelectedLabels: false,
              iconSize: 20.0,
              items: allDestinations.map((Destination destination) {
                return BottomNavigationBarItem(
                  icon: Icon(destination.iconData),
                  label: destination.label,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class Categories {
  final String title;
  bool exp;

  Categories({required this.title, required this.exp});
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _searchController;
  late List<CategoryItemView> categories;
  late List<Product> products;

  int _size = 5;
  bool showMore = false;

  @override
  void initState() {
    categories = [
      const CategoryItemView(
          categoryTitle: 'Tables', categoryImagePath: 'assets/tables.jpg'),
      const CategoryItemView(
          categoryTitle: 'Chairs', categoryImagePath: 'assets/chairs.jpg'),
      const CategoryItemView(
          categoryTitle: 'Sofas', categoryImagePath: 'assets/sofas.jpg'),
      const CategoryItemView(
          categoryTitle: 'Bed', categoryImagePath: 'assets/bed.jpg'),
      const CategoryItemView(
          categoryTitle: 'Dresser', categoryImagePath: 'assets/dresser.jpg'),
      const CategoryItemView(
          categoryTitle: 'Lighting', categoryImagePath: 'assets/lighting.jpg'),
    ];
    products = List.empty();
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    context.read<ProductCubit>().fetchProducts(Category.tables);
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductStateFetching) {
          if (state.products.isNotEmpty) {
            setState(() {
              products = state.products;
            });
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.circle_notifications_rounded),
              color: const Color.fromRGBO(205, 24, 79, 1.0),
              iconSize: 35.0,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                elevation: 0.0,
                backgroundColor: Colors.white,
                flexibleSpace: Row(
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
              ),
              SliverAppBar(
                backgroundColor: Colors.white,
                titleSpacing: 0.0,
                title: const Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(
                        () {
                          showMore = showMore ? false : true;
                          _size = showMore ? categories.length : 5;
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(205, 24, 79, 0.0),
                    ),
                    child: Text(
                      showMore ? 'Show Less' : 'Show More',
                      style: const TextStyle(
                          color: Color.fromRGBO(113, 113, 113, 1.0)),
                    ),
                  ),
                ],
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return categories[index];
                  },
                  childCount: _size,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 0.6,
                ),
              ),
              SliverPersistentHeader(
                delegate: Delegate(title: 'Items'),
                pinned: true,
                floating: false,
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ProductItemView(
                      productTitle: products[index].productTitle,
                    );
                  },
                  childCount: products.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final String title;

  Delegate({required this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 35.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 35;

  @override
  double get minExtent => 35;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
