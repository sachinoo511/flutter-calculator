import 'package:flutter/material.dart';
import 'package:calculator/button_logic.dart';
import 'dart:math';


class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String number1 = "";
  String operand = "";
  String number2 = "";


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(children: [

          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: Text(
                   "$number1$operand$number2".isEmpty?"0":"$number1$operand$number2",
                   style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),

          Wrap(
            children: Btn.buttonValues.map((value) =>
                SizedBox(
                  //value == Btn.n0 ? screenSize.width / 2 :
                    width: screenSize .width / 4,
                    height: screenSize.width / 5,

                    child: buildButton(value))
            ).toList(),
          ),
          //button Section

        ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
        padding: const EdgeInsets.all(2),
        child: Material(
          color: getBtnColor(value),
          clipBehavior: Clip.hardEdge,
          shape: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () => onBtnTab(value) ,
            child: Center(
              child: Text(value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold ,color: Colors.white),),
            ),
          ),
        )
    );

  }

  void onBtnTab(String value){
  if(value==Btn.del){
    delete();
    return;
  }
  if(value==Btn.clr){
    clearAll();
    return;
  }
  if(value==Btn.per){
    calculateToPercentage();
    return;
  }
  if(value==Btn.calculate){
    calculate();
    return;
  }
  appendValue(value);

  }
  void calculate(){
    if(number1.isEmpty) return;
    if(operand.isEmpty) return;
    if(number2.isEmpty) return;
  final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);

    var result = 0.0;
    switch (operand){
      case Btn.add:
        result = num1+num2;
        break;
      case Btn.subtract:
        result = num1-num2;
        break;
      case Btn.divide:
        result = num1/num2;
        break;
      case Btn.multiply:
        result = num1*num2;
        break;
      case Btn.root:
        result = sqrt(num1);
        break;
      default:


    }
    setState((){
      number1 = "$result";
      if(number1.endsWith(".0")){
        number1 = number1.substring(0,number1.length-2);
      }
      operand = "";
      number2 = "";

    });




  }

  // void findSquartRoot(){
  //   final number = double.parse(number1);
  //   setState(() {
  //     number1 = "${(sqrt(number)}"
  //   });
  //
  // }

  void calculateToPercentage(){
    if(number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty){

    }
    if(operand.isNotEmpty){

    }

    final number = double.parse(number1);
    setState(() {
      number1 = "${(number/100)}";
      operand = "";
      number2 = "";
    });
  }

  void clearAll(){
    setState(() {
      number1= "";
      operand= "";
      number2 = "";
    });
  }

  void delete(){
    if(number2.isNotEmpty){
      number2 = number2.substring(0, number2.length-1);
    }else if(operand.isNotEmpty){
      operand = "";
    }else if(number1.isNotEmpty){
      number1 = number1.substring(0,number1.length-1);
    }

    setState(() {

    });

  }
  void calculateRoot() {
    if (number1.isEmpty) return;

    final double num1 = double.parse(number1);
    final result = sqrt(num1);

    setState(() {
      number1 = "$result";
      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = "";
      number2 = "";
    });
  }


  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (operand.isNotEmpty && number2.isNotEmpty) {
        // Handle other operations if needed
      }
      operand = value;
    } else if (number1.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        value = "0.";
      }
      if (value == Btn.root) {
        // Handle root operation
        calculateRoot();
        return;
      }
      number1 += value;
    } else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        value = "0.";
      }
      number2 += value; // Append to number2 if operand is not empty
    }

    setState(() {
      // Update the UI if necessary
    });
  }




  Color getBtnColor(value){
    return  [Btn.del,Btn.clr].contains(value)?
    Colors.blueGrey :
    [
      Btn.per,
      Btn.multiply,
      Btn.add,
      Btn.subtract,
      Btn.divide,
      Btn.calculate].contains(value)?Color(int.parse('0xFF212121')):
    Color(0xFF727272);
  }

}
