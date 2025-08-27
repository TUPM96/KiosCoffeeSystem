import 'package:flutter/material.dart';

void debouncer(VoidCallback func, {int millis = 1000}) {
  Future.delayed(Duration(milliseconds: millis), func);
}
