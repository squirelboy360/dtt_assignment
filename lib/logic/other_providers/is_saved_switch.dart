import 'package:dtt/logic/overview_provider.dart';

mixin IsSavedSwitch on OverviewProvider {
  Future<void> checkSavedStatus(int id) async {
    if (favoriteBox.containsKey(id)) {
      isStored = true;
    } else {
      isStored = false;
    }
    notifyListeners();
  }
}
