import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator() {
  return Padding(
    padding: EdgeInsets.all(50),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
