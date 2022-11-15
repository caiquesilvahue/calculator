import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'BalooChettan2',
  textTheme: const TextTheme(
    headline4: TextStyle(color: Colors.white, fontSize: 45),
    headline5: TextStyle(color: Colors.white, fontSize: 28),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ))),
  ),
);

const Color topButtonColor = Color.fromARGB(216, 82, 82, 82);
const Color functionButtonColor = Color.fromRGBO(250, 158, 13, 1);
const Color numberButtonColor = Color.fromRGBO(112, 112, 112, 50);
