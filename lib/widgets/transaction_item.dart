import 'dart:math';

import 'package:expense_planner/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../customClasses/UniqueColorGenerator.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTx;

  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}
Color myColor;
class _TransactionItemState extends State<TransactionItem> {
  @override
  void initState() {
    const availableColors = [Colors.blue, Colors.black, Colors.red, Colors.purple, Colors.green];
    //const myColors = UniqueColorGenerator.getColor(); //강의랑은 다르게 나는 class로 불러오는거라서 여따쓰는게 아님~

    myColor = availableColors[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          CircleAvatar(
           backgroundColor: myColor,
//            backgroundColor: UniqueColorGenerator.getColor(),
            radius: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColorLight,
                width: 2,
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              '\$${widget.transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.transaction.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                //intl 패키지로 날짜 설정.
                DateFormat.yMMMd().format(widget.transaction.date),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          //강의에서는 ListTile에서의 trailing 으로 배치함. 나는 Expanded(SizedBox)로!!!
          Expanded(child: SizedBox()),
          MediaQuery.of(context).size.width > 500
              ? FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text('delete'),
                  textColor: Theme.of(context).errorColor,
                  onPressed: () => widget.deleteTx(widget.transaction.id),
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => widget.deleteTx(widget.transaction.id),
                )
        ],
      ),
    );
  }
}
