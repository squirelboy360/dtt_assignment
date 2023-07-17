import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dtt/logic/overview_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../model/overview_model.dart';
import '../overview_providers/get_location.dart';

mixin GetData on OverviewProvider, GetLocation {
//put data to hivebox
  Future<void> putData(data) async {
    await hiveBox.clear();
    for (var house in data) {
      hiveBox.add(house); // Added each model individually
    }
    notifyListeners();
  }

  //get data from api
  Future<void> getDataFromAPI() async {
    var headers = {'Access-Key': apiKey};
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<OverviewModel> newData =
          List.from(data).map((e) => OverviewModel.fromJson(e)).toList();
      newData.sort((b, a) {
        return b.price.compareTo(a.price);
      });
      await putData(newData);
      searchResults = List.from(houses);
    }

    notifyListeners();
  }

  //get Data from api and only display on network detected and user actually has internet
  Future<void> getData() async {
    if (hiveBox.isNotEmpty) {
      houses = hiveBox.values.toList();
      //ensure getLocation method is well called(it will work offline too
      getLocation();
    } else {
      await getDataFromAPI();
      houses = hiveBox.values.toList();
      //ensure getLocation method is well called
      getLocation();
      notifyListeners();
    }
    // Check internet connectivity
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      http.Response response = await http.get(Uri.parse(sampleURL));
      if (response.statusCode != 200) {
        isConnected = false;
        onlineImageNotifier = false;
        if (kDebugMode) {
          print('status code is not 200');
        }
      }
      if (kDebugMode) {
        print('image state: $onlineImageNotifier');
      }
      notifyListeners();
    } else {
      http.Response response = await http.get(Uri.parse(sampleURL));
      if (response.statusCode == 200) {
        isConnected = true;
        onlineImageNotifier = true;
      }
      if (kDebugMode) {
        print(onlineImageNotifier);
      }
      await getDataFromAPI(); // Call the method to fetch data from the API
      notifyListeners();
    }

    // Set the search results to the houses list
    searchResults = List.from(houses);
    //on connection change from offline to online or vice-versa
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        http.Response response = await http.get(Uri.parse(sampleURL));
        if (response.statusCode != 200) {
          isConnected = false;
          onlineImageNotifier = false;
        }
        isConnected = false;
      } else {
        http.Response response = await http.get(Uri.parse(sampleURL));
        if (response.statusCode == 200) {
          isConnected = true;
          onlineImageNotifier = true;
        }
        await getDataFromAPI(); // Call the method to fetch data from the API
      }
      notifyListeners();
    });

    notifyListeners();
  }
}
