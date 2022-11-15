import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String? text;
  const Display({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey[850],
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(20),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            text!,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}
