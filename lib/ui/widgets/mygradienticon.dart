import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyGradientIcon extends StatelessWidget {
  

  final IconData icon;
  final double size;
  final Gradient gradient;
  final bool isFlaticon;

  MyGradientIcon({Key key, this.icon, this.size = 24, this.gradient, this.isFlaticon = false });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child:
        (isFlaticon)
        ?
        FaIcon(
          icon,
          size: size,
          color: Colors.white,
        )
        :
        Icon(
          icon,
          size: size,
          color: Colors.white,
        )
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}