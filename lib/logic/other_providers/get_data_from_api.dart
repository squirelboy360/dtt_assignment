import 'dart:convert';
import 'package:dtt/logic/overview_provider.dart';
import 'package:http/http.dart' as http;

import '../../model/overview_model.dart';

mixin GetDataFromApi on OverviewProvider {
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
}
