import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoProvider extends ChangeNotifier{
  Future<void>openDTTSite(String urlString){
    notifyListeners();
    return launchUrlString(urlString);
  }
}
