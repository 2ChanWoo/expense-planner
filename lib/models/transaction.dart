//@required 하니까 자동생성됨.import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart'; //Udemy 에서 @required 빨간줄 해결 import


class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
