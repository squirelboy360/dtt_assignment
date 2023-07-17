import 'package:dtt/logic/overview_provider.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

mixin DeleteData on OverviewProvider {
  ///delete data by id reference
  Future<void> deleteData(int id) async {
    if (favoriteBox.containsKey(id)) {
      favoriteBox.delete(id);
      savedHouses = favoriteBox.values.toList();
      Vibrate.feedback(FeedbackType.light);
      notifyListeners();
    }
  }
}
