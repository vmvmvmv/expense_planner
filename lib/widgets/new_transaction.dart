import 'package:expense_planner/widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTx;

  NewTransaction(this.onAddTx) {
    print('contructor NewTransaction widget');
  }

  @override
  _NewTransactionState createState() {
    print('createState NewTransaction widget');

    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('contructor NewTransaction state');
  }

  @override
  void initState() {
    print('initState NewTransaction');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print('didUpdate NewTransaction');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose NewTransaction');
    super.dispose();
  }

  void _onSubmitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _selectedDate == null) {
      return;
    }

    widget.onAddTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop(); // close popup
  }

  void _onShowDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((chosenDate) {
      if (chosenDate == null) {
        return;
      }

      setState(() {
        _selectedDate = chosenDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _onSubmitData,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _onSubmitData,
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'No date chosen'
                            : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child:
                              AdaptiveButton('Choose date', _onShowDatePicker))
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: _onSubmitData,
                  textColor: Colors.purple,
                  child: Text('Add transaction'),
                )
              ],
            ),
          )),
    );
  }
}
