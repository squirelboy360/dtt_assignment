import 'package:dtt/logic/overview_provider.dart';
import 'package:url_launcher/url_launcher.dart';

mixin OpenMap on OverviewProvider {
  void openGoogleMaps(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    notifyListeners();
  }
}
