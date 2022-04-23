import 'package:flutter/material.dart';

import '../db/transactions_database.dart';
import '../model/transaction.dart';
import '../widgets/Loading.dart';
import '../widgets/transaction_list.dart';
class CategoryDetailPage extends StatefulWidget {
  CategoryDetailPage(this.category,this.color);
  final String category;
  final Color color;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  List<Transaction>? transactions;
  bool loading = false;

  @override
  void initState(){
    super.initState();
    refrechTransactions();
  }


  Future refrechTransactions() async{
    setState(() => loading = true);
    this.transactions = await TransactionsDatabase.instance.redAllTransactions();
    setState(() => loading = false);
  }
  Future deleteTransaction(int id) async {
    await TransactionsDatabase.instance.delete(id);
    refrechTransactions();
  }

  List<Transaction> get categoryTransactions {
    return transactions!.where((t) {
      return t.category == widget.category;
    }).toList();
  }
  double get total {
    double totalValue = 0;
    categoryTransactions != null ? categoryTransactions.forEach((element) {
      totalValue = totalValue + element.price;
    }) : totalValue = 0;
    return totalValue;
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.category)),
      body: loading ? Loading() :
      (categoryTransactions != null && categoryTransactions.isNotEmpty) ?
      SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Total:",style: TextStyle(fontSize: 26)),
                    SizedBox(width: 10),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FittedBox(
                              child: Text(total.toString(),style: TextStyle(fontSize: 26,color: Colors.redAccent)),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
            TransactionList(categoryTransactions, deleteTransaction)
          ],
        ),
      ) : Center(child: Text("No Transactions"),) ,
    );
  }
}
