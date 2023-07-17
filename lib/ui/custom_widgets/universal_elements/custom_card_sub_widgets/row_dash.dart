import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../static/color_pallet.dart';

class RowDashboard extends StatelessWidget {
  const RowDashboard({
    super.key,
    required this.n,
    required this.url,
  });

  final int n;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          url,
          color: DTTColors().kMedium,
          width: 15,
          allowDrawingOutsideViewBox: false,
        ),
        Text(
          n.toString(),
          style: TextStyle(fontSize: 9, color: DTTColors().kMedium),
        ),
      ],
    );
  }
}
