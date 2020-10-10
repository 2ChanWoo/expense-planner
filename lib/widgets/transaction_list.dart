import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                    //style: ,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png'),
                  ),
                  //직계 위젯이 Column이라 무제한 높이라, 오버픽셀발생
                ],
              );
            },
          )
        : ListView(
            children: <Widget>[
              ...transactions //children에 리스트가 하나밖에 없으면, Spread연산자 안붙여두댐 ( <Widget>[] 빼고 )
                  .map(
                    (tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTx: deleteTx,
                    ),
                  )
                  .toList(),
            ],
          );
    // 아 나는 처음에 이렇게 했다가 뭣땜에 아래처럼 바꾼거같은데,,
    // return throwList(transactions, index, context);
  }
}
