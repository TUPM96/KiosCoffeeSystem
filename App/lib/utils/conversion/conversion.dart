import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color hexToColor(String hexCode) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hexCode),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hexCode.substring(1), radix: 16) +
        (hexCode.length == 7 ? 0xff000000 : 0x00000000),
  );
}

String formatDateToString(DateTime date) {
  final formatDate = DateFormat('EEEE, d-MM-y HH:mm');
  return formatDate.format(date);
}

String formatDateAltToString(DateTime date) {
  final formatDate = DateFormat('EEEE, d-MM-y');
  return formatDate.format(date);
}

DateTime formatStringToDateTime(String str) {
  final formattedDate = DateFormat('EEEE, d-MM-y HH:mm').parse(str);
  return formattedDate;
}
