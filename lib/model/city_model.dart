class CityModel {
  CityModel({
    required this.status,
    required this.cityList,
  });

  late final bool status;
  late final List<City> cityList;

  CityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    cityList = List.from(json['data']).map((e) => City.fromJson(e)).toList();
  }
}

class City {
  City({
    required this.id,
    required this.uid,
    required this.city,
    required this.dateAdded,
    required this.status,
    required this.popularLocations,
    required this.image,
    required this.lastUpdated,
  });

  late final String id;
  late final String uid;
  late final String city;
  late final String dateAdded;
  late final String status;
  late final List<PopularLocations> popularLocations;
  late final String image;
  late final String? lastUpdated;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    city = json['city'];
    dateAdded = json['date_added'];
    status = json['status'];
    popularLocations = List.from(json['popular_locations'])
        .map((e) => PopularLocations.fromJson(e))
        .toList();
    image = json['image'];
    lastUpdated = json['last_updated'];
  }
}

class PopularLocations {
  PopularLocations({
    required this.location,
    required this.address2,
    required this.pin,
    required this.country,
  });

  late final String location;
  late final String address2;
  late final String pin;
  late final String country;

  PopularLocations.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    address2 = json['address2'];
    pin = json['pin'];
    country = json['country'];
  }
}
