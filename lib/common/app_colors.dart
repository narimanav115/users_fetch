
import 'package:flutter/material.dart';

class AppColors {
  static const Color mainBackground = Color(0xFF23282F);
  static const Color cellBackground = Color(0xFF3C3E44);
  static const Color greyColor = Color(0xFF9E9E9E);
  static BorderRadius borderRadius = BorderRadius.circular(8.0);
  static BoxDecoration userBoxDecoration =
      BoxDecoration(color: cellBackground, borderRadius: borderRadius);
  static const Widget statusSquareActive = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.green,
    ),
    child: SizedBox(
      height: 8,
      width: 8,
    ),
  );
  static const Widget statusSquareInActive = DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.red,
      ),
    child: SizedBox(
      height: 8,
      width: 8,
    ),
  );

  static const TextStyle userNameTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white
  );
  static const TextStyle userIdTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey
  );
  static const TextStyle userNameTextStyleBig = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: Colors.white
  );
  static const TextStyle userIdTextStyleBig = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.grey
  );

}
