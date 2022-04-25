import 'package:flutter/material.dart';
import 'package:masroufi/pages/stats_page.dart';
import 'all_depenses.dart';
import 'categories.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int currentIndex = 0;
  final screens = [
    AllDepenses(),
    Categories(),
    StatsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: ((index) => setState(() => currentIndex = index)),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: "Depenses",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "Categories"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: "stats"
            )
          ],
        )
    );
  }
}
