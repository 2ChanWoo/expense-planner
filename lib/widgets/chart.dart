import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groundTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract((Duration(days: index)));
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      //   print(DateFormat.E().format(weekDay));
      //   print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
        //'amount': totalSum.toStringAsFixed(2)
      };
    });
  }

  double get totalSpending {
    return groundTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groundTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groundTransactionValues.map((e) {
          return Flexible(
           // fit: FlexFit.tight,
            child:  ChartBar(
            e['day'],
            e['amount'],
            totalSpending == 0.0 ? 0.0 : (e['amount'] as double) / totalSpending,
          )
          );
        }).toList(),
      ),
    );
//    return Card(
//      elevation: 6,
//      margin: EdgeInsets.all(20),
//      child: Row(
//        children: groundTransactionValues.map((e) =>
//        Text('${e['day']}: ${e['amount']}')
//        ).toList(),
//      ),
//    );
  }
}