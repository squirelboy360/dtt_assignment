import 'package:hive/hive.dart';

part 'overview_model.g.dart';

@HiveType(typeId: 1)
class OverviewModel extends HiveObject {
  @HiveField(0)
  String image;

  @HiveField(1)
  int price;

  @HiveField(2)
  int bedrooms;

  @HiveField(3)
  int bathroom;

  @HiveField(4)
  int size;

  @HiveField(5)
  String description;

  @HiveField(6)
  String zip;

  @HiveField(7)
  String city;

  @HiveField(8)
  int latitude;

  @HiveField(9)
  int longitude;

  @HiveField(10)
  String createdDate;

  @HiveField(11)
  bool isSaved;

  @HiveField(12)
  int id;


  OverviewModel({
    required this.id,
    required this.image,
    this.isSaved = false,
    required this.price,
    required this.bedrooms,
    required this.size,
    required this.description,
    required this.zip,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.bathroom,
    required this.createdDate,
  });

  //for storing saved data(thanks for the suggestion,i never knew)

  OverviewModel clone() {
    return OverviewModel(
        id: id,
        image: image,
        price: price,
        bedrooms: bedrooms,
        size: size,
        description: description,
        zip: zip,
        city: city,
        latitude: latitude,
        longitude: longitude,
        bathroom: bathroom,
        createdDate: createdDate);
  }

  factory OverviewModel.fromJson(Map<String, dynamic> jsonString) {
    return OverviewModel(
      id: jsonString[
          'id'], // Replace 'id' with the actual key used in your API response
      image: jsonString['image'],
      price: jsonString['price'],
      bedrooms: jsonString['bedrooms'],
      size: jsonString['size'],
      description: jsonString['description'],
      zip: jsonString['zip'],
      city: jsonString['city'],
      latitude: jsonString['latitude'],
      longitude: jsonString['longitude'],
      bathroom: jsonString['bathrooms'],
      createdDate: jsonString['createdDate'],
    );
  }
}

//👾-!for reference purpose-!//
///i made drastic changes to this file, in case i forget and there is a bug,this should be the cause
///(i got rid of it) //
///  // void toggleSavedStatus() {
//   //   isSaved = !isSaved;
//   //   save(); // Save the updated object in Hive
//   // }