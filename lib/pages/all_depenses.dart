import 'package:masroufi/model/transaction.dart';
import 'package:masroufi/widgets/Loading.dart';
import 'package:masroufi/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import '../db/transactions_database.dart';
class AllDepenses extends StatefulWidget {
  const AllDepenses({Key? key}) : super(key: key);
  @override
  State<AllDepenses> createState() => _AllDepensesState();
}
class _AllDepensesState extends State<AllDepenses> {
  List<Transaction>? allTransations;

  bool loading = true;



  @override
  void initState(){
    super.initState();
    refrechTransactions();
  }

  Future refrechTransactions() async{
    setState(() => loading = true);
    this.allTransations = await TransactionsDatabase.instance.redAllTransactions();
    setState(() => loading = false);
  }
  Future deleteTransaction(int id) async {
    await TransactionsDatabase.instance.delete(id);
    refrechTransactions();
  }
  double get total {
    double totalValue = 0;
    allTransations != null ? allTransations!.forEach((element) {
      totalValue = totalValue + element.price;
    }) : totalValue = 0;
    return totalValue;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Depnses"),elevation: 0),
      body:
      loading ? Loading() :
      (allTransations != null && allTransations!.isNotEmpty) ?
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
            TransactionList(allTransations!, deleteTransaction)
          ],
        ),
      ) : Center(child: Text("No Transactions"),) ,
    );
  }
}
