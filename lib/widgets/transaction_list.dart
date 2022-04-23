import 'package:flutter/material.dart';
import 'package:masroufi/model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  TransactionList(this.transactions,this.delete);
  Function delete;


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
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context,index)  {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: getCategoryColor(transactions[index].category),width: 2)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(transactions[index].title,
                      style: TextStyle(fontSize: 22,color: getCategoryColor(transactions[index].category))),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat().format(transactions[index].date)),
                        Text('${transactions[index].price.toString()} DZA', style: TextStyle(
                            color: Colors.red),)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => delete(transactions[index].id),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty
                            .all(Colors.red)),
                        label: Text("Delete"),
                        icon: Icon(Icons.delete),
                      ),
                      SizedBox(width: 10)
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }

}