import 'package:flutter/material.dart';

import 'button.dart';

class ButtonRow extends StatelessWidget {
  final List<Button>? buttons;
  const ButtonRow({super.key, this.buttons});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons!.fold(<Widget>[], (list, button) {
          list.isEmpty
              ? list.add(button)
              : list.addAll([const SizedBox(width: 1), button]);
          return list;
        }),
      ),
    );
  }
}
