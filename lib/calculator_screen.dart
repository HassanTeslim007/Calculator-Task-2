
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:myapp/core/colors.dart';
import 'package:myapp/core/utils.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  String previousDisplay = '';
  double? previousValue;
  String? operation;
  bool waitingForNext = false;
  double memory = 0.0;
  bool hasMemory = false;

  void _onButtonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          _clear();
          break;
        case 'CE':
          _clearEntry();
          break;
        case '±':
          _toggleSign();
          break;
        case '%':
          _percentage();
          break;
        case '√':
          _squareRoot();
          break;
        case '1/x':
          _reciprocal();
          break;
        case 'x²':
          _square();
          break;
        case '+':
        case '-':
        case '×':
        case '÷':
          _operation(buttonText);
          break;
        case '=':
          _equals();
          break;
        case 'MC':
          _memoryClear();
          break;
        case 'MR':
          _memoryRecall();
          break;
        case 'M+':
          _memoryAdd();
          break;
        case 'M-':
          _memorySubtract();
          break;
        case '.':
          _decimal();
          break;
        default:
          _number(buttonText);
      }
    });
  }

  void _clear() {
    display = '0';
    previousDisplay = '';
    previousValue = null;
    operation = null;
    waitingForNext = false;
  }

  void _clearEntry() {
    display = '0';
    waitingForNext = false;
  }

  void _toggleSign() {
    if (display != '0') {
      if (display.startsWith('-')) {
        display = display.substring(1);
      } else {
        display = '-$display';
      }
    }
  }

  void _percentage() {
    double value = double.parse(display);
    display = (value / 100).toString();
   formatDisplay(display);
  }

  void _squareRoot() {
    double value = double.parse(display);
    if (value >= 0) {
      display = math.sqrt(value).toString();
     formatDisplay(display);
    }
  }

  void _reciprocal() {
    double value = double.parse(display);
    if (value != 0) {
      display = (1 / value).toString();
     formatDisplay(display);
    }
  }

  void _square() {
    double value = double.parse(display);
    display = (value * value).toString();
   formatDisplay(display);
  }

  void _operation(String op) {
    if (previousValue != null && operation != null && !waitingForNext) {
      _equals();
    }
    previousValue = double.parse(display);
    operation = op;
    previousDisplay = '$display $op';
    waitingForNext = true;
  }

  void _equals() {
    if (previousValue != null && operation != null) {
      double current = double.parse(display);
      double result = 0;

      switch (operation) {
        case '+':
          result = previousValue! + current;
          break;
        case '-':
          result = previousValue! - current;
          break;
        case '×':
          result = previousValue! * current;
          break;
        case '÷':
          if (current != 0) {
            result = previousValue! / current;
          } else {
            display = 'Error';
            return;
          }
          break;
      }

      display = result.toString();
     formatDisplay(display);
      previousValue = null;
      operation = null;
      previousDisplay = '';
      waitingForNext = true;
    }
  }

  void _memoryClear() {
    memory = 0.0;
    hasMemory = false;
  }

  void _memoryRecall() {
    display = memory.toString();
   formatDisplay(display);
    waitingForNext = true;
  }

  void _memoryAdd() {
    memory += double.parse(display);
    hasMemory = true;
  }

  void _memorySubtract() {
    memory -= double.parse(display);
    hasMemory = true;
  }

  void _decimal() {
    if (waitingForNext) {
      display = '0.';
      waitingForNext = false;
    } else if (!display.contains('.')) {
      display += '.';
    }
  }

  void _number(String number) {
    if (waitingForNext) {
      display = number;
      waitingForNext = false;
    } else {
      display = display == '0' ? number : display + number;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Display Area
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (previousDisplay.isNotEmpty)
                    Text(
                      previousDisplay,
                      style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                    ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (hasMemory)
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.memory,
                            color: Colors.orange,
                            size: 20,
                          ),
                        ),
                      Flexible(
                        child: Text(
                          display,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Button Area
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  // Memory and Advanced Functions Row
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('MC', getMemoryButtonColor()),
                        _buildButton('MR', getMemoryButtonColor()),
                        _buildButton('M+', getMemoryButtonColor()),
                        _buildButton('M-', getMemoryButtonColor()),
                      ],
                    ),
                  ),
                  // Advanced Functions Row
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('√', getAdvancedButtonColor()),
                        _buildButton('x²', getAdvancedButtonColor()),
                        _buildButton('1/x', getAdvancedButtonColor()),
                        _buildButton('÷', getOperatorButtonColor()),
                      ],
                    ),
                  ),
                  // Clear and Percentage Row
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('C', getClearButtonColor()),
                        _buildButton('CE', getClearButtonColor()),
                        _buildButton('%', getAdvancedButtonColor()),
                        _buildButton('×', getOperatorButtonColor()),
                      ],
                    ),
                  ),
                  // Numbers Row 1
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('7', getNumberButtonColor()),
                        _buildButton('8', getNumberButtonColor()),
                        _buildButton('9', getNumberButtonColor()),
                        _buildButton('-', getOperatorButtonColor()),
                      ],
                    ),
                  ),
                  // Numbers Row 2
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('4', getNumberButtonColor()),
                        _buildButton('5', getNumberButtonColor()),
                        _buildButton('6', getNumberButtonColor()),
                        _buildButton('+', getOperatorButtonColor()),
                      ],
                    ),
                  ),
                  // Numbers Row 3
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('1', getNumberButtonColor()),
                        _buildButton('2', getNumberButtonColor()),
                        _buildButton('3', getNumberButtonColor()),
                        _buildButton('±', getAdvancedButtonColor()),
                      ],
                    ),
                  ),
                  // Bottom Row
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('0', getNumberButtonColor()),
                        _buildButton('.', getNumberButtonColor()),
                        _buildButton('=', getEqualsButtonColor()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildButton(String text, Color color) => calculatorButton(
    text,
    color,
    onPressed: (text) => _onButtonPressed(text),
  );
}

