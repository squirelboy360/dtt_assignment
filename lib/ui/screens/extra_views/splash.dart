import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dtt/logic/parent_provider.dart';
import 'package:dtt/static/color_pallet.dart';
import 'package:dtt/ui/screens/extra_views/location_error_screen.dart';
import 'package:dtt/ui/screens/navigation_views/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Provider.of<ParentProvider>(context, listen: false).getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 100,
        backgroundColor: DTTColors().kDefaultRed,
        splash: 'assets/logo/noBg.png',
        duration: 1000,
        splashTransition: SplashTransition.rotationTransition,
        nextScreen:
            Provider.of<ParentProvider>(context).doNotAllowUserIntoApp == true
                ? const LocationError()
                : const NavigationScreen());
  }
}
