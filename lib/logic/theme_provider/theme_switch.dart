import 'package:dtt/logic/overview_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

mixin ThemeSwitch on OverviewProvider {
  void themeSwitchCaller() {
    // Check theme preference
    if (preferences.isNotEmpty) {
      themePreference = preferences.get('themePreference');
    } else {
      if (kDebugMode) {
        print('theme data preference not set yet');
      }
    }
  }

//
  void themeSwitch() async {
    preferences.clear();
    bool theme = isDarkMode = !isDarkMode;
    preferences.put('themePreference', theme);
    themePreference = preferences.get('themePreference');
    Vibrate.feedback(FeedbackType.success);
    if (kDebugMode) {
      print("themeData set");
    }
    notifyListeners();
  }
}
