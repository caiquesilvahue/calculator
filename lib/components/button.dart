import 'package:flutter/material.dart';

import '../app_theme.dart';

class Button extends StatelessWidget {
  final String? text;
  final bool big;
  final Color color;
  final Icon? icon;
  final void Function(String)? callBack;

  const Button({
    super.key,
    required this.text,
    this.big = false,
    this.color = numberButtonColor,
    this.icon,
    required this.callBack,
  });

  const Button.big({
    super.key,
    required this.text,
    this.big = true,
    this.color = topButtonColor,
    this.icon,
    required this.callBack,
  });

  const Button.operation({
    super.key,
    required this.text,
    this.big = false,
    this.color = functionButtonColor,
    this.icon,
    required this.callBack,
  });

  const Button.backspace({
    super.key,
    this.text = 'backspace',
    this.icon = const Icon(
      Icons.backspace_outlined,
      color: Colors.white,
    ),
    this.big = false,
    this.color = functionButtonColor,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        child: text != 'backspace'
            ? Text(
                text!,
                style: Theme.of(context).textTheme.headline5,
              )
            : icon,
        onPressed: () => callBack!(text!),
      ),
    );
  }
}
