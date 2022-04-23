import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {


  final Function onClick;

  NewTransaction(this.onClick);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();

  final priceController = new TextEditingController();

  String? category;


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

  
  void dataSubmit(){
    try{
      String? category = this.category;
      String title = titleController.text;
      double price = double.parse(priceController.text);
      if(category == null || title.isEmpty || price <= 0){
        return;
      }
      widget.onClick(title,price,category);
      Navigator.of(context).pop();
    }
    catch (error){
      return;
    }

  }
  @override
  Widget build(BuildContext context) {
    DropdownMenuItem<String> buildMenuItem(String item)=>
        DropdownMenuItem(value: item,
          child: Text(
            item,
            style: TextStyle(color: getCategoryColor(item)),
          ));
    return Card(
      child:
      Padding(
        padding: EdgeInsets.all(10),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DropdownButton<String>(
              isExpanded: true,
                value: category,
                items: categories.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => category = value!)),
            TextField(decoration: InputDecoration(labelText: "titre"),controller: titleController,
              textInputAction: TextInputAction.next),
            TextField(decoration: InputDecoration(labelText: "prix"), controller: priceController,
              keyboardType: TextInputType.number,onSubmitted: (_) => dataSubmit()),
            TextButton(
                onPressed: dataSubmit,
                child: Text("Ajoute")
            )
          ],
        ),
      ),
    );

  }
}

