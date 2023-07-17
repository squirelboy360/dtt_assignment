import 'package:flutter/material.dart';

import '../../../static/color_pallet.dart';

class FontSizeEnhancer extends StatelessWidget {
  const FontSizeEnhancer({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });

  final Function onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            color: DTTColors().kStrongGrey,
            borderRadius: BorderRadius.circular(30)),
        height: 50,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(color: DTTColors().kLightGreyBg),
            ),
            Icon(
              icon,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
