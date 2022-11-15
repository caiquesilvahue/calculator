import 'package:flutter/material.dart';

import '../components/display.dart';
import '../components/keyboard.dart';
import '../models/memory.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final Memory memory = Memory();

  _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange[400]!, Colors.orange[900]!],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Display(text: memory.value),
          Keyboard(callBack: _onPressed),
        ],
      ),
    );
  }
}
