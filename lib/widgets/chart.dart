import 'package:masroufi/model/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {


  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String,Object>> get transactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double total = 0;
      for(int i = 0;i<recentTransactions.length;i++){
        if(recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            weekDay.year == weekDay.year){
          total = total + recentTransactions[i].price;
        }
      }
      return {'j' : DateFormat.E().format(weekDay).substring(0,1) , 'total' : total} ;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child:Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: transactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Text("${e['j']}",style: TextStyle(color: Colors.blue,fontSize: 18),),
                  SizedBox(height: 5),
                  FittedBox(child: Text("${e['total'].toString()}"))
                ],
              ),
            );
          }).toList(),
        ),
        
      ),
    );
  }
}
