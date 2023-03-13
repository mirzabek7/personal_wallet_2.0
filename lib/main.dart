// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:my_wallet/models/expences.dart';
import 'package:my_wallet/widgets/add_expence.dart';

import './widgets/header.dart';
import './widgets/body.dart';

void main(List<String> args) {
  // WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: MyWallet(),
    );
  }
}

class MyWallet extends StatefulWidget {
  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  Expences expenceData = Expences();
  DateTime selectedDate = DateTime.now();
  bool _showExpenseList = false;

  void showCalendar(BuildContext context) {
    showMonthPicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedDate = value;
        });
      }
    });
  }

  void lastMonth() {
    if (selectedDate.year == 2022 && selectedDate.month == 1) {
      return;
    }
    setState(() {
      selectedDate =
          DateTime(selectedDate.year, selectedDate.month - 1, selectedDate.day);
    });
  }

  void nextMonth() {
    if (selectedDate.year == DateTime.now().year &&
        selectedDate.month == DateTime.now().month) {
      return;
    }
    setState(() {
      selectedDate =
          DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day);
    });
  }

  void addNewExpence(String title, double amount, DateTime date) {
    setState(
      () {
        expenceData.addNewExpence(title, amount, date);
      },
    );
  }

  void showAddExpenceWindow(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return AddExpence(addNewExpence);
      },
    );
  }

  void deleteExpense(String id) {
    setState(
      () {
        expenceData.delete(id);
      },
    );
  }

  Widget showPortraitItems(totalByMonth, deviceHeight) {
    return Column(
      children: [
        Container(
          height: deviceHeight > 640 ? deviceHeight * 0.3 : deviceHeight * 0.25,
          child: Header(
              showCalendar, selectedDate, lastMonth, nextMonth, totalByMonth),
        ),
        Container(
          height: deviceHeight > 640 ? deviceHeight * 0.7 : deviceHeight * 0.75,
          child: Body(expenceData.itemsByMonth(selectedDate), totalByMonth,
              deleteExpense),
        ),
      ],
    );
  }

  Widget showLandscapeItems(totalByMonth, deviceHeight) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Ro'yxatni ko'rsatish: "),
            Switch.adaptive(
                value: _showExpenseList,
                onChanged: (value) {
                  setState(() {
                    _showExpenseList = value;
                  });
                })
          ],
        ),
        _showExpenseList
            ? Container(
                height: deviceHeight * 0.85,
                child: Body(expenceData.itemsByMonth(selectedDate),
                    totalByMonth, deleteExpense),
              )
            : Container(
                height: deviceHeight * 0.9,
                child: Header(showCalendar, selectedDate, lastMonth, nextMonth,
                    totalByMonth),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalByMonth = expenceData.totalExpencesByMonth(selectedDate);
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text("Shaxsiy Hamyon"),
      actions: Platform.isIOS
          ? [
              IconButton(
                onPressed: () {
                  showAddExpenceWindow(context);
                },
                icon: Icon(Icons.add),
              ),
            ]
          : [],
    );
    final topPadding = MediaQuery.of(context).padding.top;
    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        topPadding;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLandscape
                ? showLandscapeItems(totalByMonth, deviceHeight)
                : showPortraitItems(totalByMonth, deviceHeight),
          ],
        ),
      ),
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              onPressed: () {
                showAddExpenceWindow(context);
              },
              child: Icon(Icons.add),
            )
          : Container(),
    );
  }
}
