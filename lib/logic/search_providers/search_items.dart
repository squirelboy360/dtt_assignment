import 'package:dtt/logic/overview_provider.dart';

mixin SearchItems on OverviewProvider {
  ///SearchAlgorithm//
  void searchStaffs(String query) {
    if (query.isEmpty) {
      isSearchNotFound = false;
      // If the query is empty, show all staffs
      searchResults = List.from(houses);
    } else {
      // Filter the staffs based on the query
      searchResults = houses.where((staff) {
        var staffAddress = staff.zip.toLowerCase();
        var staffPlace = staff.city.toUpperCase();
        return staffAddress.contains(query.toLowerCase()) ||
            staffPlace.contains(query);
      }).toList();
      isSearchNotFound = searchResults.isEmpty;
    }
    notifyListeners();
  }
}
