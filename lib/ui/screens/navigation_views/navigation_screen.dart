import 'package:dtt/logic/navigation_providers/navigation_provider.dart';
import 'package:dtt/logic/parent_provider.dart';
import 'package:dtt/static/color_pallet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rotating_icon_button/rotating_icon_button.dart';

import '../../custom_widgets/overview_ui_elements/refresh_butt.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Provider.of<ParentProvider>(context).themePreference;
    return Scaffold(
      body: Provider.of<NavigationProvider>(context)
          .allScreens[Provider.of<NavigationProvider>(context).index],
      extendBody: false,
      bottomNavigationBar: Builder(builder: (context) {
        double screenWidth = MediaQuery.of(context).size.width;

        if (screenWidth > 600) {
          if (kDebugMode) {
            print(screenWidth);
          }
        }
        return BottomNavigationBar(
            showUnselectedLabels: false,
            showSelectedLabels: false,
            elevation: 2,
            backgroundColor:
                isDarkMode ? DTTColors().kTransBlack : DTTColors().kTransWhite,
            selectedItemColor:
                isDarkMode ? DTTColors().kDefaultRed : DTTColors().kStrongGrey,
            unselectedItemColor: DTTColors().kLight,
            ///////////////Navigation Logic////////////
            currentIndex: Provider.of<NavigationProvider>(context).index,
            onTap: (value) {
              Provider.of<NavigationProvider>(context, listen: false).value =
                  value;
              Provider.of<NavigationProvider>(context, listen: false)
                  .valueChanger();
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.info,
                    size: 30,
                  ),
                  label: 'Info'),
            ]);
      }),
      //Contains refresh button and theme changer
      floatingActionButton: Builder(builder: (context) {
        final providerProps = Provider.of<ParentProvider>(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RotatingIconButton(
                    onTap: () {
                      Provider.of<ParentProvider>(context, listen: false)
                          .themeSwitch();
                    },
                    background:
                        isDarkMode ? DTTColors().kStrongGrey : Colors.white,
                    shape: ButtonShape.circle,
                    elevation: 2,
                    child: Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),

            ///visibility widget will show refresh button on user offline condition met
            Visibility(
              visible:
                  providerProps.isConnected || providerProps.onlineImageNotifier
                      ? false
                      : true,
              child: const Padding(
                padding: EdgeInsets.all(150.0),
                child: RefreshButton(),
              ),
            ),
          ],
        );
      }),
    );
  }
}
