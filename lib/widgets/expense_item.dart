// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  final String title;
  final DateTime date;
  final double amount;
  final Key key;
  final Function deleteExpense;
  final String id;

  ExpenseItem(
      this.title, this.date, this.amount, this.key, this.deleteExpense, this.id)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      onDismissed: (direction) {
        deleteExpense(id);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.amber),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(DateFormat("dd MMMM, y").format(date)),
        trailing: Text("$amount so'm"),
      ),
    );
  }
}
