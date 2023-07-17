import 'package:dtt/logic/overview_provider.dart';
import 'package:flutter/material.dart';

mixin GetSaves on OverviewProvider {
  void getSaves() {
    savedHouses = favoriteBox.values.toList();
    if (favoriteBox.isNotEmpty) {
      isFavoriteNumberVisible = true;
    } else {
      isFavoriteNumberVisible = false;
    }
    //I wrap notify listeners with this to ensure notifyListeners is only executed after current frame is built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
