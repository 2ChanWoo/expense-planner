// Udemy 에서 import 'package:expense_planner/transaction.dart';
//를 지우고 최상의 방법은 아니라고 위처럼 간결한 import로 변경했는데 굳이 그런 이유가 뭐지?
//자동으로 채워주는걸 지우고,,

import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';

import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
        //머테리얼 디자인 중, primary 색상보다 accentColor 가 우선되는 것들이 있다.
        //그 중 하나가 Floating button이다
        //이 경우, accentColor가 있으면 해당 색상으로, 없다면 하위설정인 primary 색상이 적용된다.
        fontFamily: 'Quicksand',

// 글씨 크기만 줄어들고 적용이 아상하게 됨. (light 와 dark , 폰트사이즈 등등)///////////
        //ㄴ> title -> headline6 로 변경됨. 1~5는 똑같이 크기변경 등이 안되구.
        // ++light <-> dark 는 변화가 없는데?
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    //기능이 많이 없어졌는데..
                    // 적용안됌.
                    headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ))),
        ///////////////////////////////////////////////// 강의 95

        //위에 것이 appbarTheme이라 그런거였나,, textTheme도 새로만드니 bold까지 추가가 되네.
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
//    Transaction(
//      id: 't1',
//      title: 'New Shoes',
//      amount: 69.99,
//      date: DateTime.now(),
//    ),
//    Transaction(
//      id: 't2',
//      title: 'Weekly Groceries',
//      amount: 16.53,
//      date: DateTime.now(),
//    ),
//    Transaction(
//      id: 't3',
//      title: 'Lotto',
//      amount: 4.99,
//      date: DateTime.now(),
//    ),
//    Transaction(
//      id: 't4',
//      title: 'SoJu',
//      amount: 1.6,
//      date: DateTime.now(),
//    ),
//    Transaction(
//      id: 't5',
//      title: 'cigarette',
//      amount: 4.5,
//      date: DateTime.now(),
//    ),
//    Transaction(
//      id: 't6',
//      title: 'KT mobile',
//      amount: 69.99,
//      date: DateTime.now(),
//    ),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          //style: Theme.of(context).textTheme.headline6, //theme에서 정의안하고 이렇게 디폴트로 쓰네,, --?
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
//            Container(
//              width: double.infinity,
//              child: Card(
//                color: Colors.blue,
//                child: Text(
//                  'CHART!',
//                  //style: Theme.of(context).textTheme.headline6, 왜 이걸 안하고, textTheme의 dark로 바꾸면 흰색이 되는거지??
//                ),
//                elevation: 5,
//              ),
//            ),
            Chart(_recentTransaction),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }
}
