import 'package:flutter/material.dart';

class CategoryItemView extends StatelessWidget {
  const CategoryItemView(
      {Key? key, required this.categoryTitle, required this.categoryImagePath})
      : super(key: key);

  final String categoryTitle;
  final String categoryImagePath;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: (height >= 480 && height < 720
              ? 60.0
              : 70.0),
          width: (height >= 480 && height < 720
              ? 60.0
              : 70.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(categoryImagePath),
              fit: BoxFit.cover
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: Text(categoryTitle, style: const TextStyle(fontWeight: FontWeight.w500),),
        ),
      ],
    );
  }
}


/*
SizedBox(
height: (height >= 480 && height < 720 ? 90.0 : 110.0),
child: GridView.count(
crossAxisCount: 5,
childAspectRatio: 0.6,
shrinkWrap: true,
children: const [
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Tables',
categoryImagePath: 'assets/tables.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Chairs',
categoryImagePath: 'assets/chairs.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Sofas',
categoryImagePath: 'assets/sofas.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Bed',
categoryImagePath: 'assets/bed.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Dresser',
categoryImagePath: 'assets/dresser.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Dresser',
categoryImagePath: 'assets/dresser.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Dresser',
categoryImagePath: 'assets/dresser.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Dresser',
categoryImagePath: 'assets/dresser.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Dresser',
categoryImagePath: 'assets/dresser.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Dresser',
categoryImagePath: 'assets/dresser.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Dresser',
categoryImagePath: 'assets/dresser.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Dresser',
categoryImagePath: 'assets/dresser.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Dresser',
categoryImagePath: 'assets/dresser.jpg'),
),
Padding(
padding: EdgeInsets.only(right: 16.0),
child: CategoryItemView(
categoryTitle: 'Dresser',
categoryImagePath: 'assets/dresser.jpg'),
),
],
),
),*/
