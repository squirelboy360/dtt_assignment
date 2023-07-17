import 'package:dtt/ui/custom_widgets/universal_elements/custom_card_sub_widgets/row_dash.dart';
import 'package:flutter/material.dart';

import '../../../../static/color_pallet.dart';

class RowDashboards extends StatelessWidget {
  const RowDashboards({
    super.key,
    required this.nBed,
    required this.nBath,
    required this.nLayers,
    required this.distance,
  });

  final int nBed;
  final int nBath;
  final int nLayers;
  final double distance;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: RowDashboard(n: nBed, url: 'assets/Icons/ic_bed.svg'),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: RowDashboard(n: nBath, url: 'assets/Icons/ic_bath.svg'),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: RowDashboard(n: nLayers, url: 'assets/Icons/ic_layers.svg'),
      ),
      Row(children: [
        RowDashboard(n: distance.toInt(), url: 'assets/Icons/ic_location.svg'),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(
            'km',
            style: TextStyle(color: DTTColors().kMedium, fontSize: 9),
          ),
        )
      ])
    ]);
  }
}
