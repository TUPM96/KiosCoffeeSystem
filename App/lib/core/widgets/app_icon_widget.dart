import 'package:boilerplate/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconWidget extends StatelessWidget {
  final String image;

  static const String suffixType = '.svg';

  const AppIconWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //getting screen size
    var size = MediaQuery.of(context).size;

    //calculating container width
    double imageSize;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      imageSize = (size.width * 0.20);
    } else {
      imageSize = (size.height * 0.20);
    }

    return image.endsWith(suffixType)
        ? SvgPicture.asset(
            image,
            fit: BoxFit.cover,
            allowDrawingOutsideViewBox: true,
            semanticsLabel: 'Octareach Logo',
          )
        : Container(
            child: Image.asset(
              Assets.appLogo,
              height: 200,
              width: 200,
            ),
          );
  }
}
