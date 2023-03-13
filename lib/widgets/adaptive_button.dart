import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String title;
  final Function handler;
  final bool filled;
  const AdaptiveButton(
      {required this.title, required this.handler, this.filled = false});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? filled
            ? ElevatedButton(
                onPressed: () {
                  handler();
                },
                child: Text(title),
              )
            : TextButton(
                onPressed: () {
                  handler;
                },
                child: Text(title),
              )
        : filled
            ? CupertinoButton.filled(
                child: Text(title),
                onPressed: () {
                  handler();
                })
            : CupertinoButton(
                child: Text(title),
                onPressed: () {
                  handler();
                },
              );
  }
}
