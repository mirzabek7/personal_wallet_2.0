import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double totalLimitPercentage;
  ProgressBar(this.totalLimitPercentage);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(212, 219, 239, 1)),
      child: FractionallySizedBox(
        heightFactor: 2,
        widthFactor: totalLimitPercentage / 100,
        child: Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
            gradient: LinearGradient(
              colors: [Colors.red, Colors.red, Colors.red.shade200],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.red,
                blurRadius: 12,
                spreadRadius: -2.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
