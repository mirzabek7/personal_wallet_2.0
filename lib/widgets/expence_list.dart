// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:my_wallet/models/expences.dart';
import 'expense_item.dart';

class ExpenceList extends StatelessWidget {
  final List<Expence> expences;
  final Function deleteExpense;

  ExpenceList(this.expences, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width,
        height: constraints.maxHeight,
        margin: const EdgeInsets.only(top: 110),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
        ),
        child: expences.length > 0
            ? ListView.builder(
                padding: const EdgeInsets.only(
                  top: 15,
                  right: 7,
                ),
                itemBuilder: (ctx, i) {
                  return ExpenseItem(
                    expences[i].title,
                    expences[i].date,
                    expences[i].amount,
                    ValueKey(expences[i].id),
                    deleteExpense,
                    expences[i].id,
                  );
                },
                itemCount: expences.length,
              )
            : Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(children: [
                  Text(
                    "Xarajatlar mavjud emas!",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/images/expenses.png",
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ]),
              ),
      );
    });
  }
}
