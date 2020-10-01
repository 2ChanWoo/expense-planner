import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        : ListView.builder(
            reverse: true,
            //ctx 보면 buildcontext ctx 네? 자동적으로..?
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return throwList(transactions,index, context);
            },
          );
  }
  Widget throwList(List<Transaction> tx,int index, BuildContext ctx) {
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
                color: Theme.of(ctx).primaryColorLight,
                width: 2,
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              '\$${tx[index].amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(ctx).primaryColorDark,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                tx[index].title,
                style: Theme.of(ctx).textTheme.headline6,
              ),
              Text(
                //intl 패키지로 날짜 설정.
                DateFormat.yMMMd().format(tx[index].date),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          //강의에서는 ListTile에서의 trailing 으로 배치함. 나는 Expanded(SizedBox)로!!!
          Expanded(child: SizedBox()),
          IconButton(
            icon: Icon(Icons.delete),
            color: Theme.of(ctx).errorColor,
            onPressed: () => deleteTx(tx[index].id),
          )
        ],
      ),
    );
  }
}
