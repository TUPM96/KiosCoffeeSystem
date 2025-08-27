import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  AppBarTheme get appBarTheme => Theme.of(this).appBarTheme;

  ElevatedButtonThemeData get elevatedButtonTheme =>
      Theme.of(this).elevatedButtonTheme;

  ScaffoldMessengerState get scaffoldMes => ScaffoldMessenger.of(this);

  FocusScopeNode get focusScope => FocusScope.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  AppLocalizations get appLocale => AppLocalizations.of(this);

  Color get primary => Theme.of(this).colorScheme.primary;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  NavigatorState get navigator => Navigator.of(this);
}

extension DateExt on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime extractToDateOnly() {
    return DateTime(year, month, day);
  }
}
