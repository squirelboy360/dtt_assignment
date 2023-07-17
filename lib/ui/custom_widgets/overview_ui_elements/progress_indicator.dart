import 'package:flutter/material.dart';

import '../../../static/color_pallet.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: DTTColors().kDarkGrey,
      color: DTTColors().kDefaultRed,
      minHeight: 25,
    );
  }
}
