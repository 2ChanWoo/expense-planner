import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print('Constructor NewTranscation Widget');
  }

  @override
  _NewTransactionState createState() {
    print('create NewTranscation Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('Constructor NewTranscation State');
  }

  // 확인용 출력
//  @override
//  void initState() {
//    print('initState()');
//    // TODO: implement initState
//    super.initState();
//  }
//
//  @override
//  void didUpdateWidget(NewTransaction oldWidget) {
//    print('didUpdateWidget()');
//    super.didUpdateWidget(oldWidget);
//  }
//
//  @override
//  void dispose() {
//    print('dispose()');
//    super.dispose();
//  }

  //93. 강의보면, 5:43 에 뭐가 더 많이 있는데 나는 건더띄었는데..? 특히 widget.addTx

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null){
      print('Do entered.');
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
    print(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    //굳이 카드로해서 조금더 이쁘게 만든듯. 괜찮음.
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                // onChanged: (val) => amountInput = val,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //강의에서는 둘 사이의 거리를 Text를 Expanded로 감싸 위젯의 크기를 늘려 거리를 벌림.
                  children: <Widget>[
                    Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
                //이렇게 하는 이유는 아마, 입력받은 문자열들을 검수할 때,
                //지저분하게 onPressed 에 작성하는 것 보다, 다른 함수에서 처리하는게 깔끔하기 때문인건가?
              ),
            ],
          ),
        ),
      ),
    );
  }
}
