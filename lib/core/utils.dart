  import 'package:flutter/material.dart';
import 'package:myapp/core/colors.dart';

Widget calculatorButton(String text, Color color, {int flex = 1, void Function(String)? onPressed}) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => onPressed?.call(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: getTextColor(color),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            padding: EdgeInsets.all(0),
          ),
          child: Container(
            height: double.infinity,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

    void formatDisplay(String display) {
    double value = double.parse(display);
    if (value == value.roundToDouble()) {
      display = value.toInt().toString();
    } else {
      display = value.toString();
    }
  }

    String formatNumber(double number) {
    if (number == number.roundToDouble()) {
      return number.toInt().toString();
    } else {
      return number.toString();
    }
  }