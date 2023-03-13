// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class EditMonthlyBudget extends StatefulWidget {
  final Function changedBudgetLimit;
  final double budgetLimit;

  EditMonthlyBudget(this.changedBudgetLimit, this.budgetLimit);

  @override
  State<EditMonthlyBudget> createState() => _EditMonthlyBudgetState();
}

class _EditMonthlyBudgetState extends State<EditMonthlyBudget> {
  late TextEditingController budgetController;

  @override
  void initState() {
    budgetController = TextEditingController();
    budgetController.text = widget.budgetLimit.toStringAsFixed(0);
    super.initState();
  }

  @override
  void dispose() {
    budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Oylik byudjet miqdori"),
            controller: budgetController,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("BEKOR QILISH"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (budgetController.text.isEmpty) {
                    return;
                  }
                  double amount = double.parse(budgetController.text);
                  if (amount <= 0) {
                    return;
                  }
                  widget.changedBudgetLimit(amount);
                  Navigator.of(context).pop();
                },
                child: Text("O'ZGARTIRISH"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
