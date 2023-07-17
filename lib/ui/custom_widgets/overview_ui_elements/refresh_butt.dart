import 'package:dtt/logic/parent_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:provider/provider.dart';
import 'package:rotating_icon_button/rotating_icon_button.dart';
import '../../../static/color_pallet.dart';

class RefreshButton extends StatefulWidget {
  const RefreshButton({
    super.key,
  });

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> {
  @override
  Widget build(BuildContext context) {
    return RotatingIconButton(
      onTap: () {
        Provider.of<ParentProvider>(context, listen: false).getData();
        Vibrate.feedback(FeedbackType.success);
      },
      elevation: 10.0,
      shadowColor: DTTColors().kDefaultRed,
      borderRadius: 20.0,
      rotateType: RotateType.semi,
      clockwise: false,
      background: Colors.white,
      child: Center(
        child: Icon(
          Icons.refresh,
          color: DTTColors().kDefaultRed,
        ),
      ),
    );
  }
}
