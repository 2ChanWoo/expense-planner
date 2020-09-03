import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
//      child: SingleChildScrollView(
//        child: Column(

    //////////////////////////////////////////////
      child: ListView.builder(
        reverse: true,
        //ctx 보면 buildcontext ctx 네? 자동적으로..?
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return throwList(transactions[index]);
        },
      ),
     //////////////////////////////////////////////

/*
      child: ListView(
        children: transactions.map((tx) => throwList(tx)).toList(),
      ),
*/

//        ),
//      ),
    );
  }

  Widget throwList(Transaction tx) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.purple,
                width: 2,
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              '\$${tx.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                tx.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                //intl 패키지로 날짜 설정.
                DateFormat.yMMMd().format(tx.date),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

