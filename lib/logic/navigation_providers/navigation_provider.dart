import 'package:flutter/material.dart';

import '../../ui/screens/main_screens/info.dart';
import '../../ui/screens/main_screens/overview.dart';

class NavigationProvider extends ChangeNotifier {
  int index = 0;
  int? value;

  List<Widget> allScreens = [const OverviewScreen(), const InfoScreen()];

  NavigationProvider({this.value});

  void valueChanger() {
    index = value!;
    notifyListeners();
  }
}
