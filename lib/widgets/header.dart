// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Header extends StatelessWidget {
  final Function showCalendar;
  final DateTime selectedDate;
  final Function nextMonth;
  final Function lastMonth;
  final double totalByMonth;

  Header(this.showCalendar, this.selectedDate, this.lastMonth, this.nextMonth,
      this.totalByMonth);

  @override
  Widget build(BuildContext context) {
    final isLastDate = selectedDate.year == DateTime.now().year &&
        selectedDate.month == DateTime.now().month;
    final isFirstDate = selectedDate.year == 2022 && selectedDate.month == 1;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: TextButton(
              onPressed: () {
                showCalendar(context);
              },
              child: Text(
                DateFormat("MMMM, y").format(selectedDate),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isFirstDate ? Colors.grey : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    lastMonth();
                  },
                  icon: Icon(
                    Icons.arrow_left,
                    size: 30,
                    color: isFirstDate ? Colors.grey : Colors.black,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalByMonth.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      height: 0.7,
                    ),
                  ),
                  Text(
                    "so'm",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isLastDate ? Colors.grey : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    nextMonth();
                  },
                  icon: Icon(
                    Icons.arrow_right,
                    size: 30,
                    color: isLastDate ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
