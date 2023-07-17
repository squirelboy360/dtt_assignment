import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:dtt/static/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../static/color_pallet.dart';

class SearchNotFoundWidget extends StatelessWidget {
  const SearchNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Images/search_state_empty.png',
              scale: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: AutoSizeText(
                maxLines: 2,
                AppLocalizations.noResultFoundAlertText(context),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: DTTColors().kLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
