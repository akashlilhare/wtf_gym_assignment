class GymModel {
  GymModel({
    required this.pagination,
    required this.status,
    required this.message,
    required this.gymList,
  });

  late final List<Pagination> pagination;
  late final bool status;
  late final String message;
  late final List<Gym> gymList;

  GymModel.fromJson(Map<String, dynamic> json) {
    pagination = List.from(json['pagination'])
        .map((e) => Pagination.fromJson(e))
        .toList();
    status = json['status'];
    message = json['message'];
    gymList = List.from(json['data']).map((e) => Gym.fromJson(e)).toList();
  }
}

class Pagination {
  Pagination({
    required this.pagination,
    required this.limit,
    required this.pages,
  });

  late final int pagination;
  late final int limit;
  late final int pages;

  Pagination.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'];
    limit = json['limit'];
    pages = json['pages'];
  }
}

class Gym {
  Gym({
    required this.pocName,
    required this.pocMobile,
    required this.userId,
    required this.gymName,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.latitude,
    required this.longitude,
    required this.pin,
    required this.country,
    required this.name,
    required this.distance,
    this.addonCategory,
    this.addonCatId,
    this.offerType,
    this.offerValue,
    required this.distanceText,
    required this.durationText,
    required this.duration,
    required this.rating,
    this.text1,
    this.text2,
    this.planName,
    this.planDuration,
    this.planPrice,
    this.planDescription,
    this.coverImage,
    required this.gallery,
    required this.benefits,
    required this.type,
    required this.description,
    required this.status,
    required this.slug,
    required this.categoryId,
    required this.totalRating,
    required this.isPartial,
    required this.isCash,
    required this.categoryName,
    this.wtfShare,
    required this.isDiscount,
  });

  late final String pocName;
  late final String pocMobile;
  late final String userId;
  late final String gymName;
  late final String address1;
  late final String address2;
  late final String city;
  late final String state;
  late final String latitude;
  late final String longitude;
  late final String pin;
  late final String country;
  late final String name;
  late final String distance;
  late final Null addonCategory;
  late final Null addonCatId;
  late final String? offerType;
  late final String? offerValue;
  late final String distanceText;
  late final String durationText;
  late final String duration;
  late final num rating;
  late final String? text1;
  late final String? text2;
  late final String? planName;
  late final dynamic planDuration;
  late final dynamic planPrice;
  late final String? planDescription;
  late final String? coverImage;
  late final List<dynamic> gallery;
  late final List<Benefits> benefits;
  late final String type;
  late final String description;
  late final String status;
  late final String slug;
  late final String categoryId;
  late final int totalRating;
  late final String isPartial;
  late final int isCash;
  late final String categoryName;
  late final int? wtfShare;
  late final int isDiscount;

  Gym.fromJson(Map<String, dynamic> json) {
    pocName = json['poc_name'];
    pocMobile = json['poc_mobile'];
    userId = json['user_id'];
    gymName = json['gym_name'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    pin = json['pin'];
    country = json['country'];
    name = json['name'];
    distance = json['distance'];
    addonCategory = null;
    addonCatId = null;
    offerType = null;
    offerValue = null;
    distanceText = json['distance_text'];
    durationText = json['duration_text'];
    duration = json['duration'];
    rating = json['rating'];
    text1 = null;
    text2 = null;
    planName = null;
    planDuration = null;
    planPrice = null;
    planDescription = null;
    coverImage = null;
    gallery = List.castFrom<dynamic, dynamic>(json['gallery']);
    benefits =
        List.from(json['benefits']).map((e) => Benefits.fromJson(e)).toList();
    type = json['type'];
    description = json['description'];
    status = json['status'];
    slug = json['slug'];
    categoryId = json['category_id'];
    totalRating = json['total_rating'];
    isPartial = json['is_partial'];
    isCash = json['is_cash'];
    categoryName = json['category_name'];
    wtfShare = null;
    isDiscount = json['is_discount'];
  }
}

class Benefits {
  Benefits({
    required this.id,
    required this.uid,
    required this.gymId,
    required this.name,
    required this.breif,
    required this.image,
    required this.status,
    required this.dateAdded,
    this.lastUpdated,
    required this.images,
  });

  late final int id;
  late final String uid;
  late final String gymId;
  late final String name;
  late final String breif;
  late final String image;
  late final String status;
  late final String dateAdded;
  late final String? lastUpdated;
  late final String images;

  Benefits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    gymId = json['gym_id'];
    name = json['name'];
    breif = json['breif'];
    image = json['image'];
    status = json['status'];
    dateAdded = json['date_added'];
    lastUpdated = json['last_updated'];
    images = json['images'];
  }
}
