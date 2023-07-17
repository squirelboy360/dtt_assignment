import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/overview_model.dart';
import 'dart:math';

abstract class OverviewProvider extends ChangeNotifier {
  //This class contains all required variables/strings/bool/lists/ints e.t.c required by other extending classes
  Box<OverviewModel> hiveBox = Hive.box('DttAppBox');
  Box<OverviewModel> favoriteBox = Hive.box('Favorites');
  Box preferences = Hive.box('systemPreferences');
  //
  List<OverviewModel> savedHouses = [];
  //
  List<OverviewModel> houses = [];
  List<OverviewModel> searchResults = [];
  //
  //theming
  bool themePreference = false;
  bool isDarkMode = false;

  ///in case user denies access to location, this will be default
  late double defaultUserLong = 0;
  late double defaultUserLat = 0;

  //..//
  int nfavorites = 0;
  bool isStored = false;
  bool isFavoriteNumberVisible = false;
  bool isConnected = false;
  bool onlineImageNotifier = false;
  bool isSearchNotFound = false;
  String apiKey = '98bww4ezuzfePCYFxJEWyszbUXc7dxRx';
  String url = 'https://intern.d-tt.nl/api/house';
  String imgUrl = 'https://intern.d-tt.nl';
  double defaultFontSize = 16;
  bool doNotAllowUserIntoApp = true;
  String userNotAllowedToApp = '';
  bool locationDisabled = false;
  final sampleURL = 'http://google.com';
  late StreamSubscription<ConnectivityResult> subscription;

  bool isStoredById(int id) {
    return favoriteBox.containsKey(id);
  }

  bool isHouseSaved(int id) {
    return favoriteBox.values.any((house) => house.id == id);
  }

  String formatAmount(String amount) {
    String price = amount;
    String priceInText = "";
    int counter = 0;
    for (int i = (price.length - 1); i >= 0; i--) {
      counter++;
      String str = price[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = ",$str$priceInText";
      }
    }
    return priceInText.trim();
  }

  //calculate distance from longitude and latitude
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    // Convert latitudes and longitudes from degrees to radians
    double lat1Rad = degreesToRadians(lat1);
    double lon1Rad = degreesToRadians(lon1);
    double lat2Rad = degreesToRadians(lat2);
    double lon2Rad = degreesToRadians(lon2);

    // Difference between latitudes and longitudes
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Haversine formula
    double a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}
