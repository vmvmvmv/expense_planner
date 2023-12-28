import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

import 'package:expense_planner/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function onDeleteTransaction;

  TransactionList(this.transactions, this.onDeleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              children: [
                Text('No transactions added yet',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constrains.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                    key: ValueKey(tx.id),
                    transaction: tx,
                    onDeleteTransaction: onDeleteTransaction))
                .toList(),
          );
  }
}
