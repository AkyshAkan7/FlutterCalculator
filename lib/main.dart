import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String result = '0';
  String expression = '+';

  // Button logic
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        result = '0';
      } else if(buttonText == '+/-') {
        if (expression == '+') {
          result = '-$result';
          expression = '-';
        } else {
          result = result.substring(1);
          expression = '+';
        }
      }
      else if (buttonText == '=') {
        result = result.replaceAll('x', '*');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(result);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch(error) {
          result = 'Error';
        }
      } else {
          result += buttonText;
      }
    });
  }

  // Create button method
  Widget createButton(String buttonText, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      color: buttonColor,
      child: FlatButton(
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
              color: Colors.black,
              width: 1,
              style: BorderStyle.solid
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              color: Colors.white
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.black,
                  alignment: Alignment.centerRight,
                  height: MediaQuery.of(context).size.height * 0.25 - MediaQuery.of(context).padding.top,
                  padding: EdgeInsets.fromLTRB(0, 30, 10, 0),
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 70,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              createButton('C', Colors.black87),
                              createButton('+/-', Colors.black87),
                              createButton('%', Colors.black87),
                              createButton('/', Colors.orange),
                            ],
                          ),
                          TableRow(
                            children: [
                              createButton('7', Colors.grey),
                              createButton('8', Colors.grey),
                              createButton('9', Colors.grey),
                              createButton('x', Colors.orange),
                            ],
                          ),
                          TableRow(
                            children: [
                              createButton('4', Colors.grey),
                              createButton('5', Colors.grey),
                              createButton('6', Colors.grey),
                              createButton('-', Colors.orange),
                            ],
                          ),
                          TableRow(
                            children: [
                              createButton('1', Colors.grey),
                              createButton('2', Colors.grey),
                              createButton('3', Colors.grey),
                              createButton('+', Colors.orange),
                            ],
                          ),
                          TableRow(
                            children: [
                              createButton('0', Colors.grey),
                              createButton('.', Colors.grey),
                              createButton('', Colors.grey),
                              createButton('=', Colors.orange),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
