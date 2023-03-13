// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_textfield.dart';
import 'adaptive_button.dart';

class AddExpence extends StatefulWidget {
  final Function addNewExpence;
  AddExpence(this.addNewExpence);
  @override
  State<AddExpence> createState() => _AddExpenceState();
}

class _AddExpenceState extends State<AddExpence> {
  DateTime? selectedDate;
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void showNewExpenceCalendar(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    ).then(
      (value) {
        setState(
          () {
            if (value != null) {
              selectedDate = value;
            }
          },
        );
      },
    );
  }

  void submit() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        selectedDate == null) {
      return;
    }
    var title = titleController.text;
    var amount = double.parse(amountController.text);
    if (amount <= 0) {
      return;
    }

    widget.addNewExpence(title, amount, selectedDate);
    Navigator.of(context).pop();
  }

  void addIcon(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 16.0,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? MediaQuery.of(context).viewInsets.bottom + 16
                : 100),
        child: Column(
          children: [
            AdaptiveTextfield(
                controller: titleController, label: "Xarajat nomi"),
            AdaptiveTextfield(
              controller: amountController,
              label: "Xarajat miqdori",
              keyboard: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedDate == null
                    ? "Xarajat kuni tanlanmagan!"
                    : "Xarajat kuni: ${DateFormat("MMMM d, y").format(selectedDate!)}"),
                TextButton(
                  onPressed: () {
                    showNewExpenceCalendar(context);
                  },
                  child: Text("KUNNI TANLASH"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Icon tanlanmagan..."),
                TextButton(
                    onPressed: () {
                      addIcon(context);
                    },
                    child: Text("ICON TANLASH"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdaptiveButton(
                    title: "BEKOR QILISH",
                    handler: () {
                      Navigator.of(context).pop();
                    }),
                AdaptiveButton(
                  title: "KIRITISH",
                  handler: submit,
                  filled: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
