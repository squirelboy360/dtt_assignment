import 'package:dtt/static/app_localizations.dart';
import 'package:dtt/static/color_pallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../logic/info_scr_providers/info_screen_provider.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.aboutHeading(context),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                AppLocalizations.about(context),
                style: TextStyle(color: DTTColors().kMedium),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15.0),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.dAndDHeading(context),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Image.asset(
                      'assets/Images/dtt_banner/xxxhdpi/dtt_banner.png',
                      scale: 7,
                    ),
                  ),
                  Column(
                    children: [
                      Text(AppLocalizations.byDTTText(context)),
                      GestureDetector(
                          onTap: () {
                            Provider.of<InfoProvider>(context, listen: false)
                                .openDTTSite('https://d-tt.nl');
                          },
                          child: const Text(
                            'd-tt.nl',
                            style: TextStyle(color: CupertinoColors.link),
                          ))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    ));
  }
}
