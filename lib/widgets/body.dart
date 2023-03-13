// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_wallet/models/expences.dart';
import 'budget.dart';
import 'expence_list.dart';

class Body extends StatelessWidget {
  final List<Expence> expences;
  final double totalByMonth;
  final Function deleteExpense;

  Body(this.expences, this.totalByMonth, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Budget(totalByMonth),
        ExpenceList(expences, deleteExpense),
      ],
    );
  }
}
