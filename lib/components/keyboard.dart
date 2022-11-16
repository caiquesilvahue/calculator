import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'button.dart';
import 'button_row.dart';

class Keyboard extends StatelessWidget {
  final void Function(String)? callBack;
  const Keyboard({super.key, this.callBack});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Column(
          children: [
            ButtonRow(
              buttons: [
                Button(text: 'AC', callBack: callBack, color: topButtonColor),
                Button(text: '%', color: topButtonColor, callBack: callBack),
                Button.backspace(text: 'backspace', callBack: callBack),
                Button.operation(text: '/', callBack: callBack),
              ],
            ),
            const SizedBox(height: 1),
            ButtonRow(
              buttons: [
                Button(text: '9', callBack: callBack),
                Button(text: '8', callBack: callBack),
                Button(text: '7', callBack: callBack),
                Button.operation(text: 'x', callBack: callBack),
              ],
            ),
            const SizedBox(height: 1),
            ButtonRow(
              buttons: [
                Button(text: '6', callBack: callBack),
                Button(text: '5', callBack: callBack),
                Button(text: '4', callBack: callBack),
                Button.operation(text: '-', callBack: callBack),
              ],
            ),
            const SizedBox(height: 1),
            ButtonRow(
              buttons: [
                Button(text: '3', callBack: callBack),
                Button(text: '2', callBack: callBack),
                Button(text: '1', callBack: callBack),
                Button.operation(text: '+', callBack: callBack),
              ],
            ),
            const SizedBox(height: 1),
            ButtonRow(
              buttons: [
                Button.big(
                    text: '0',
                    big: true,
                    color: numberButtonColor,
                    callBack: callBack),
                Button(text: '.', callBack: callBack),
                Button.operation(text: '=', callBack: callBack),
              ],
            ),
          ],
        ));
  }
}
