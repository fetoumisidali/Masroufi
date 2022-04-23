import 'package:masroufi/db/transactions_database.dart';
import 'package:masroufi/pages/second_page.dart';
import 'package:masroufi/widgets/Loading.dart';
import 'package:masroufi/widgets/chart.dart';
import 'package:masroufi/widgets/new_transaction.dart';
import 'package:masroufi/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'model/transaction.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Depense",
  initialRoute: '/',
  routes: {
    '/' : (context) => App(),
    '/all' : (context) =>  SecondPage(),
  }
));

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Transaction>? transactions;
  bool loading = false;


  @override
  void initState(){
    super.initState();
    refrechTransactions();
  }
 @override
 void dispose() {
    TransactionsDatabase.instance.close();
    super.dispose();
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

  List<Transaction> get recent{
    return transactions!.where((t) {
      return t.date.isBefore(DateTime.now().add(Duration(days: 7)));
    }).toList();
  }
  List<Transaction> get todayTransactions {
    return transactions!.where((t) {
      return t.date.day == DateTime.now().day &&
          t.date.month == DateTime.now().month &&
          t.date.year == DateTime.now().year;
    }).toList();
  }


  Future newTransaction(String title,double price,String category) async{
    final t = Transaction(title: title, price: price, category: category,date: DateTime.now());
    await TransactionsDatabase.instance.create(t);
    refrechTransactions();
  }
  void addNewTransaction(BuildContext context){
    showModalBottomSheet(context: context, builder: (_){
      return NewTransaction(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Today Depense"),
        actions:[
           (transactions == null || transactions!.isEmpty) ? SizedBox(height: 0) :
            IconButton(onPressed: () { Navigator.pushNamed(context, '/all').whenComplete(refrechTransactions); } , icon: Icon(Icons.list_alt)),
          SizedBox(width: 10,)
        ],
      ),
      body: loading ? Loading() : (transactions == null || transactions!.isEmpty) ? Center(
        child: Text("No Transactions Yet"),
      ) :
      SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[loading ? Loading() : (transactions == null || transactions!.isEmpty) ? Center(
            child: Text("No Transactions Yet"),
          ) :
          GestureDetector(child: Chart(recent)),
            (todayTransactions == null || todayTransactions.isEmpty || todayTransactions.length == 0) ?
            Center(
                child: Text("No Transactions For Today") ) :
            TransactionList(todayTransactions,deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}