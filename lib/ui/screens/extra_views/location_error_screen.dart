import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:dtt/logic/parent_provider.dart';
import 'package:dtt/static/app_localizations.dart';
import 'package:dtt/static/color_pallet.dart';
import 'package:dtt/ui/screens/navigation_views/navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationError extends StatefulWidget {
  const LocationError({super.key});

  @override
  State<LocationError> createState() => _LocationErrorState();
}

class _LocationErrorState extends State<LocationError> {
  void showError() {}
  @override
  void initState() {
    Provider.of<ParentProvider>(context, listen: false).getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ParentProvider>(context);
    return CupertinoOnboarding(
      bottomButtonColor: DTTColors().kDefaultRed,
      bottomButtonChild:
          Text(AppLocalizations.lErrorBottomButtonChildTxt(context)),
      onPressedOnLastPage: () {
        provider.doNotAllowUserIntoApp == false
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const NavigationScreen()))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const NavigationScreen()));
        provider.defaultUserLong = 52.023;
        provider.defaultUserLat = 4.00;
      },
      pages: [
        WhatsNewPage(
          title: Text(AppLocalizations.lErrorTitle(context)),
          features: [
            WhatsNewFeature(
              icon: Icon(
                CupertinoIcons.map_pin_ellipse,
                color: CupertinoColors.systemRed.resolveFrom(context),
              ),
              title: Text(AppLocalizations.lErrorReasonForPermission(context)),
              description: Text(provider.locationDisabled
                  ? AppLocalizations.lErrorLocOn(context)
                  : AppLocalizations.lErrorLocOff(context)),
            ),
            WhatsNewFeature(
              icon: Icon(
                CupertinoIcons.floppy_disk,
                color: CupertinoColors.systemRed.resolveFrom(context),
              ),
              title: Text(AppLocalizations.lErrorStorageText(context)),
              description: Text(AppLocalizations.lErrorDescriptionTxt(context)),
            ),
          ],
        ),
      ],
    );
  }
}
