import 'package:boilerplate/utils/conversion/extensions.dart';
import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color textColor;
  final Color? borderColor;
  final String? imagePath;
  final double buttonTextSize;
  final double? height;
  final VoidCallback? onPressed;
  final ShapeBorder shape;
  final bool? isFullWidth;
  final double padding;

  RoundedButtonWidget(
      {Key? key,
      this.buttonText,
      this.buttonColor,
      this.textColor = Colors.white,
      this.onPressed,
      this.imagePath,
      this.borderColor,
      this.shape = const StadiumBorder(),
      this.buttonTextSize = 14.0,
      this.padding = 16.0,
      this.height,
      this.isFullWidth = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: padding),
      height: height,
      key: this.key,
      color: buttonColor ?? context.primary,
      shape: borderColor != null
          ? StadiumBorder(side: BorderSide(color: borderColor!))
          : shape,
      onPressed: onPressed,
      child: isFullWidth!
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                imagePath != null
                    ? Image.asset(
                        imagePath!,
                        height: 15.0,
                      )
                    : SizedBox.shrink(),
                SizedBox(width: 5.0),
                Text(
                  buttonText!,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.normal,
                    fontSize: buttonTextSize,
                  ),
                ),
              ],
            )
          : FittedBox(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                buttonText!,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: buttonTextSize,
                ),
              ),
            ),
    );
  }
}
