import 'package:boilerplate/utils/conversion/extensions.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({super.key, required this.trKey, required this.suffix});

  final String trKey;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    final locale = context.appLocale;
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            locale.translate(trKey),
          ),
          Text(
            ' ' + suffix,
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: context.colorScheme.background,
    );
  }
}
