import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboard;

  AdaptiveTextfield(
      {required this.controller, required this.label, this.keyboard});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? TextField(
            decoration: InputDecoration(labelText: label),
            controller: controller,
            keyboardType: keyboard ?? TextInputType.text,
          )
        : CupertinoTextField(
            placeholder: label,
            padding: const EdgeInsets.all(10),
            controller: controller,
            keyboardType: keyboard ?? TextInputType.text,
          );
  }
}
