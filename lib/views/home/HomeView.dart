import 'package:flutter/material.dart';
import 'package:furt/views/AccountView.dart';
import 'package:furt/views/CartView.dart';
import 'package:furt/views/Favourite.dart';
import 'package:furt/views/home/Destination.dart';

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

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
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
                            maxHeight:
                                (height >= 480 && height < 720 ? 40.0 : 60.0)),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list_rounded))
                ],
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              child: ListView(
                scrollDirection: Axis.horizontal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
