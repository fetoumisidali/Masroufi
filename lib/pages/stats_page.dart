import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../db/transactions_database.dart';
import '../model/transaction.dart';
import '../widgets/Loading.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
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
    final spending = <String,double>{};
    transactions?.forEach((item) =>
    {
      spending.update(
          item.category,
              (value) => value + item.price,
          ifAbsent: () => item.price),
    }
    );
    int spendingCount(String category){
      return transactions!.where((element) => element.category == category).length;
    }

    return Scaffold(
      appBar: AppBar(
          title: Text("Stats Page"),
          elevation: 0),
      body: loading ? Loading() : (transactions == null || transactions!.isEmpty) ? Center(
        child: Text("No Transactions Yet"),
      ) :
          Center(
            child: Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: 300,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: PieChart(
                        PieChartData(
                          sections: spending.map((category, amount) => MapEntry(
                              category, PieChartSectionData(
                            color: getCategoryColor(category),
                            titleStyle: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                backgroundColor:Colors.white ),
                            radius: 80.0,
                            value: amount,
                          ))).values.toList(),
                          sectionsSpace: 0
                        )
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: spending.keys
                          .map((category) => _Indicator(
                        color: getCategoryColor(category),
                        text: "${category} (${spendingCount(category)})",
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
          )
    );
  }
}

class _Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const _Indicator({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 16.0,
          width: 16.0,
          color: color,
        ),
        const SizedBox(width: 4.0),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
