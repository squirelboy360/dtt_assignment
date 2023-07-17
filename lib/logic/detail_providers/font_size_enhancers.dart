import 'package:dtt/logic/overview_provider.dart';

mixin FontEnhancer on OverviewProvider {
  void fontSizeIncrement() {
    defaultFontSize++;
    notifyListeners();
  }

  void fontSizeDecrement() {
    defaultFontSize--;
    notifyListeners();
  }
}
