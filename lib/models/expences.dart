// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';

class Expence {
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final IconData icon;

  Expence(
      {required this.id,
      required this.title,
      required this.date,
      required this.amount,
      this.icon = Icons.ac_unit});
}

class Expences {
  List<Expence> _item = [
    Expence(
        id: "e1",
        title: "Kitob",
        date: DateTime.now(),
        amount: 75000,
        icon: Icons.ac_unit),
    Expence(
        id: "e2",
        title: "New York bilet",
        date: DateTime.now(),
        amount: 4000000,
        icon: Icons.ac_unit),
    Expence(
        id: "e3",
        title: "AirPods",
        date: DateTime.now(),
        amount: 500000,
        icon: Icons.ac_unit),
    Expence(
        id: "e4",
        title: "Tarvuz",
        date: DateTime.now(),
        amount: 50000,
        icon: Icons.ac_unit),
  ];

  List<Expence> get item {
    return _item;
  }

  List<Expence> itemsByMonth(DateTime date) {
    return _item
        .where((expence) =>
            expence.date.month == date.month &&
            expence.date.month == date.month)
        .toList();
  }

  double totalExpencesByMonth(DateTime date) {
    final expencesByMonth = itemsByMonth(date);
    return expencesByMonth.fold(0, (previousValue, expence) {
      return previousValue + expence.amount;
    });
  }

  void addNewExpence(String title, double amount, DateTime date) {
    _item.add(
      Expence(
        id: "e${_item.length + 1}",
        title: title,
        date: date,
        amount: amount,
      ),
    );
  }

  void delete(String id) {
    _item.removeWhere((expense) => expense.id == id);
  }
}
