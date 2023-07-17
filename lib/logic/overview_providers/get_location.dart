import 'package:dtt/logic/overview_provider.dart';
import 'package:geolocator/geolocator.dart';

mixin GetLocation on OverviewProvider {
  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      doNotAllowUserIntoApp = true;
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      if (permission == LocationPermission.denied) {
        doNotAllowUserIntoApp = true;
        return Future.error('Location permissions are denied');
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      defaultUserLat = position.latitude;
      defaultUserLong = position.longitude;
      doNotAllowUserIntoApp = false;
    } catch (e) {
      userNotAllowedToApp =
          'An error occurred while getting your location. Please try again later.';
    }
    notifyListeners();
  }
}
