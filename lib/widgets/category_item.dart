import 'package:flutter/material.dart';
import 'package:masroufi/pages/category_detail_page.dart';
class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;

  CategoryItem(this.title, this.color);

  void selectCategory(BuildContext ctx){
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
      return CategoryDetailPage(title,color);
    }));
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(title,style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color
            ],
            begin: Alignment.topLeft,
            end:Alignment.bottomRight
          ),
          borderRadius: BorderRadius.circular(15)
        ),
      ),
    );
  }
}

