import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
class Categories extends StatelessWidget {

  final categories = ["Clothes","Food","House","Special"];

  Color getCategoryColor(String category) {
    switch (category) {
      case "Clothes":
        return Colors.red;
      case "Food":
        return Colors.amber;
      case "House":
        return Colors.pinkAccent;
      case "Special":
        return Colors.cyan;
      default :
        return Colors.blue;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories"),elevation: 0),
      body:GridView(
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
        ),
        children: categories.map((e) => CategoryItem(e,getCategoryColor(e))).toList(),
      ) ,
    );
  }
}

