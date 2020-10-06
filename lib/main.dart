// Udemy 에서 import 'package:expense_planner/transaction.dart';
//를 지우고 최상의 방법은 아니라고 위처럼 간결한 import로 변경했는데 굳이 그런 이유가 뭐지?
//자동으로 채워주는걸 지우고,,

import 'dart:io';

import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  //앱을 껏다 켜야 적용이 됐음.. ㅁㅈ
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
//  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
        //errorColor: Colors.red, // 디폴트값이 red이기 때문에, red로 할 경우는 굳이 할 필요 없음.
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
              ),
              button: TextStyle(color: Colors.white),
            ),
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
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Groceries', amount: 16.53, date: DateTime.now()),
    Transaction(id: 't3', title: 'Lotto', amount: 4.99, date: DateTime.now()),
    Transaction(id: 't4', title: 'SoJu', amount: 1.6, date: DateTime.now()),
    Transaction(
        id: 't5', title: 'cigarette', amount: 4.5, date: DateTime.now()),
    Transaction(
        id: 't6', title: 'KT mobile', amount: 69.99, date: DateTime.now()),
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

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    //reBuild 되기 위해서 필요. setState.
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    //많이 쓰일경우, 변수로 저장해두어서 매번 호출되지 않도록 한다!
    //핸드폰의 방향이 바뀔 경우, 자동으로 reBuild 되어 걱정 ㄴㄴ!
    final mediaQuery = MediaQuery.of(context);

    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget _appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses',
              //style: Theme.of(context).textTheme.headline6, //theme에서 정의안하고 이렇게 디폴트로 쓰네,, --?
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          );

    Widget _chartBox(double high) {
      return Container(
        height: (mediaQuery.size.height -
                _appbar.preferredSize.height -
                mediaQuery.padding.top) *
            high,
        child: Chart(_recentTransaction),
      );
    }

    final _listBox = Container(
      height: (mediaQuery.size.height -
              _appbar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
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
            //////////////////////////////////////////////////////가로모드 일 경우
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                          //_showChart = !_showChart;   //두개 다 됨
                        });
                      }),
                ],
              ),
            if (isLandscape)
              _showChart ? _chartBox(0.7) : _listBox,
            //////////////////////////////////////////////////////가로모드가 아닐 경우
            if (!isLandscape)
              _chartBox(0.3),
            if (!isLandscape)
              _listBox,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: _appbar,
          )
        : Scaffold(
            appBar: _appbar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
        //강의에서는 GestureDetector 이 추가되어있는데,
        // ModalSheet 이외의 부분을 누르면 Enqueue되게 하려는 거였나? 까묵었넹.. 맞을듯~
      },
    );
  }
}
