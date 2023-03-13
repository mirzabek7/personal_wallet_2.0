// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'progress_bar.dart';
import 'edit_mothly_budget.dart';

class Budget extends StatefulWidget {
  final double totalByMonth;

  Budget(this.totalByMonth);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  double budgetLimit = 10000000;

  void showMonthlyBudgetWindow(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (ctx) {
        return EditMonthlyBudget(changedBudgetLimit, budgetLimit);
      },
    );
  }

  void changedBudgetLimit(double amount) {
    setState(() {
      budgetLimit = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalLimitPercentage = (widget.totalByMonth / budgetLimit) * 100;
    totalLimitPercentage =
        totalLimitPercentage <= 100 ? totalLimitPercentage : 100;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: constraints.maxHeight,
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          color: Color.fromRGBO(239, 240, 250, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Oylik byudjet: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showMonthlyBudgetWindow(context);
                      },
                      icon: Icon(Icons.edit),
                      label: Text(
                        "${budgetLimit.toStringAsFixed(0)} so'm",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${totalLimitPercentage.toStringAsFixed(1)}%",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            ProgressBar(totalLimitPercentage),
          ],
        ),
      );
    });
  }
}
