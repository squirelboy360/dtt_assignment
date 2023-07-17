import 'package:dtt/logic/parent_provider.dart';
import 'package:dtt/static/color_pallet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 10),
      child: IconButton(
          onPressed: () {
            onTap();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Provider.of<ParentProvider>(context).isDarkMode == true
                ? DTTColors().kWhiteCard
                : DTTColors().kLightGreyBg,
          )),
    );
  }
}
