import 'package:dtt/logic/overview_provider.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

import '../saves_providers/get_saves.dart';

mixin StoreData on OverviewProvider, GetSaves {
  //will get called on save button pressed
  Future<void> storeData(int id) async {
    final newDataInstance = houses.firstWhere((house) => house.id == id);
    if (!savedHouses.contains(newDataInstance)) {
      favoriteBox.put(newDataInstance.id, newDataInstance.clone());
      savedHouses = favoriteBox.values.toList();
      Vibrate.feedback(FeedbackType.light);
      nfavorites = favoriteBox.length;
      getSaves();
    }
    notifyListeners();
  }
}
